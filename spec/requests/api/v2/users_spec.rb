require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
    {
        'Accept' => 'application/vnd.burajiru_ponto.v2',
        'Content-Type' => Mime[:json].to_s,
        'access-token' => auth_data['access-token'],
        'uid' => auth_data['uid'],
        'client' => auth_data['client']
    }
  end

  #HOST's
  # before { host! 'api.burajiru_ponto.dev' }
  before { host! 'api.localhost.test' }

  #Verbo GET
  describe 'GET /auth/validate_token' do

    context 'Quando o cabeçalho da requisição forem válidos' do
      before do
        get '/auth/validate_token', params: {}, headers: headers
      end

      it 'Retorna o usuário' do
        expect(json_body[:data][:id].to_i).to eq(user.id)
      end

      it 'Retorna o código status: 200 OK' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando o cabeçalho da requisição não forem válidos' do
      before do
        headers['access-token'] = "token_invalido"
        get '/auth/validate_token', params: {}, headers: headers
      end

      it 'Retorna o código status: 401 ERRO' do
        expect(response).to have_http_status(401)
      end
    end
  end

  #Verbo POST
  describe 'POST /auth' do
    before do
      # post '/users', params: { user: user_params }.to_json, headers: headers
      post '/auth', params: user_params.to_json, headers: headers
    end

    context 'Quando a requisição passando parâmetros é válida' do
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'Retorna o código status: 200' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna JSON com os dados do usuário criado' do
        expect(json_body[:data][:email]).to eq(user_params[:email])
      end
    end

    context 'Quando a requisição passando parâmetros é invalida' do
      let(:user_params) { FactoryGirl.attributes_for(:user, email: 'email_invalido@') }

      it 'Retorna o código status: 422' do
        expect(response).to have_http_status(422)
      end

      it 'Retorna JSON com os dados de erros' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe 'PUT /auth' do
    before do
      put '/auth', params: user_params.to_json, headers: headers
    end

    context 'Quando a requisição passando parâmetros é válida' do
      let(:user_params) { { email: 'new_email@burajiru_ponto.com' } }

      it 'Retorna código status: 200 OK' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna JSON com os dados do usuário atualizado' do
        expect(json_body[:data][:email]).to eq(user_params[:email])
      end
    end

    context 'Quando a requisição passando parâmetros é invalida' do
      let(:user_params) { { email: 'invalid_email@' } }

      it 'Retorna código status: 422 ERRO' do
        expect(response).to have_http_status(422)
      end

      it 'Retorna JSON com os dados de erros' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  #Verbo DELETE
  describe 'DELETE /auth' do
    before do
      # headers = { 'Accept' => 'application/vnd.burajiru_ponto.v1' }
      # delete "/users/#{user_id}", params: {}, headers: headers
      delete '/auth', params: {}, headers: headers
    end

    it 'Retorna código status: 200 OK' do
      expect(response).to have_http_status(200)
    end

    it 'Usuário removido do banco de dados' do
      expect( User.find_by(id: user.id) ).to be_nil
    end
  end

end