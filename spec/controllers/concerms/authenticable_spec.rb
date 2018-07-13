require 'rails_helper'

RSpec.describe Authenticable do

  #Simulando um controller que não existe
  controller(ApplicationController) do
    include Authenticable
  end

  let(:app_controller) { subject }


  describe '#current_user' do
    let(:user) { create(:user) }

    before do
      req = double(:headers => { 'Authorization' => user.auth_token })
      allow(app_controller).to receive(:request).and_return(req)
    end

    it 'Retorna o usuário autorizado que foi enviado no header' do
      expect(app_controller.current_user).to eq(user)
    end
  end

  describe '#authenticate_with_token!' do
    controller do
      before_action :authenticate_with_token!

      def restricted_action; end
    end

    context 'Quando não tiver nenhum usuário logado no sistema' do
      before do
        allow(app_controller).to receive(:current_user).and_return(nil)
        routes.draw { get 'restricted_action' => 'anonymous#restricted_action' }
        get :restricted_action
      end

      it 'Retorna o código status: 401' do
        expect(response).to have_http_status(401)
      end

      it 'Retorna um JSON os dados de erros.' do
        expect(json_body).to have_key(:errors)
      end
    end
  end


  describe '#user_logged_in?' do
    context 'Quando tiver um usuário logado no sistema.' do
      before do
        user = create(:user)
        allow(app_controller).to receive(:current_user).and_return(user)
      end

      it { expect(app_controller.user_logged_in?).to be true }
    end

    context 'Quando não tiver nenhum usuário logado no sistema' do
      before do
        allow(app_controller).to receive(:current_user).and_return(nil)
      end

      it { expect(app_controller.user_logged_in?).to be false }
    end
  end
end