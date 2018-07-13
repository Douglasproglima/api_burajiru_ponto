require 'rails_helper'

RSpec.describe 'Sessão da API', type: :request do

  #HOST's
  before { host! 'api.localhost.test' }
  #before { host! 'api.burajiru_ponto.test' } -> Retorna erro, mesmo setando no arquivo host do SO

  let!(:user) { create(:user) }
  let(:headers) do
    {
        'Accept' => 'application/vnd.burajiru_ponto.v1',
        'Content-Type' => Mime[:json].to_s
    }
  end

  #Verbo POST
  describe 'POST /sessions' do
    before do
      post '/sessions/', params: { session: credentials }.to_json, headers: headers
    end

    context 'Quando as credenciais do user estiverem corretas' do
      let(:credentials) { { email: user.email, password: '123456' } }

      it 'Retorna o código status: 200 OK' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna os dados do usuário autenticado(auth token)' do
        user.reload #Força a pegar os dados atuais do banco de dados.
        expect(json_body[:auth_token]).to eq(user.auth_token)
      end
    end

    context 'Quando as credenciais do user estiverem incorretas' do
      let(:credentials) { { email: user.email, password: 'invalid_password' } }

      it 'Retorna o código status: 401 ERRO' do
        expect(response).to have_http_status(401)
      end

      it 'Retornar os dados JSON com os erros' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  #Verbo DELETE
  describe 'DELETE /sessions/:id' do
    let(:auth_token) { user.auth_token }

    before do
      delete "/sessions/#{auth_token}", params: {}, headers: headers
    end

    it 'Retorna o código status: 204' do
      expect(response).to have_http_status(204)
    end

    it 'Auth Token do usuário alterado' do
      expect( User.find_by(auth_token: auth_token) ).to be_nil
    end
  end
end