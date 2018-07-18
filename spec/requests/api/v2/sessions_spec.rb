require 'rails_helper'

RSpec.describe 'Sessão da API', type: :request do

  #HOST's
  before { host! 'api.localhost.test' }
  #before { host! 'api.burajiru_ponto.test' } -> Retorna erro, mesmo setando no arquivo host do SO

  let!(:user) { create(:user) }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
    {
        'Accept' => 'application/vnd.burajiru_ponto.v2',
        'Content-Type' => Mime[:json].to_s,
        'access-token' => auth_data['access-token'],
        'client' => auth_data['client'],
        'uid' => auth_data['uid']
    }
  end

  #Verbo POST
  describe 'POST /auth/sign_in' do
    before do
      post '/auth/sign_in', params: credentials.to_json, headers: headers
    end

    context 'Quando as credenciais do user estiverem corretas' do
      let(:credentials) { { email: user.email, password: '123456' } }

      it 'Retorna o código status: 200 OK' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna as credênciais do user no cabeçalho' do
        expect(response.headers).to have_key('access-token')
        expect(response.headers).to have_key('uid')
        expect(response.headers).to have_key('client')
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
  describe 'DELETE /auth/sign_out' do
    let(:auth_token) { user.auth_token }

    before do
      delete '/auth/sign_out', params: {}, headers: headers
    end

    it 'Retorna o código status: 200' do
      expect(response).to have_http_status(200)
    end

    it 'Auth Token do usuário alterado' do
      #Re-Carrega o user para validar a sessão
      user.reload

      #Retorna se a sessão é válida: boolean
      # user.valid_token?(auth_data['access-token'], auth_data['client'])

      expect( user.valid_token?(auth_data['access-token'], auth_data['client']) ).to eq(false)

      #Segunda forma de testar
      expect( user ).not_to be_valid_token(auth_data['access-token'], auth_data['client'])
    end
  end
end