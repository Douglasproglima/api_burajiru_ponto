require 'rails_helper'

RSpec.describe 'Usuários da API', type: :request do
  #OS TESTES REALIZADOS NESSA ETAPA SÃO NO BANCO DE DADOS.

  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:headers) do
    {
        'Accept' => 'application/vnd.burajiru_ponto.v1',
        'Content-Type' => Mime[:json].to_s,
        'Authorization' => user.auth_token
    }
  end

  #HOST's
  # before { host! 'api.burajiru_ponto.dev' }
  before { host! 'api.localhost.test' }

  #Verbo GET
  describe 'GET /users/:id' do
    before do
      get "/users/#{user_id}", params: {}, headers: headers
    end

    context 'Quando o usuário existir' do
      it 'Retorna o usuário' do
        expect(json_body[:id]).to eq(user_id)
      end

      it 'Retorna o código status: 200 OK' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando o usuário não existir' do
      let(:user_id) {1000}

      it 'Retorna o código status: 404 ERRO' do
        expect(response).to have_http_status(404)
      end
    end
  end

  #Verbo POST
  describe 'POST /users' do
    before do
      post '/users', params: { user: user_params }.to_json, headers: headers
    end

    context 'Quando a requisição passando parâmetros é válida' do
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'Retorna o código status: 201' do
        expect(response).to have_http_status(201)
      end

      it 'Retorna JSON com os dados do usuário criado' do
        expect(json_body[:email]).to eq(user_params[:email])
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

  #Verbo PUT
  describe 'PUT /users/:id' do
    before do
      put "/users/#{user_id}", params: { user: user_params }.to_json, headers: headers
    end

    context 'Quando a requisição passando parâmetros é válida' do
      let(:user_params) { { email: 'new_email@burajiruponto.com' } }

      it 'Retorna código status: 200 OK' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna JSON com os dados do usuário atualizado' do
        expect(json_body[:email]).to eq(user_params[:email])
      end
    end

    context 'Quando a requisição passando parâmetros é invalida' do
      let(:user_params) { { email: 'iemail_invalido@' } }

      it 'Retorna código status: 422 ERRO' do
        expect(response).to have_http_status(422)
      end

      it 'Retorna JSON com os dados de erros' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  #Verbo DELETE
  describe 'DELETE /users/:id' do
    before do
      # headers = { 'Accept' => 'application/vnd.burajiru_ponto.v1' }
      delete "/users/#{user_id}", params: {}, headers: headers
    end

    it 'Retorna código status: 204 OK' do
      expect(response).to have_http_status(204)
    end

    it 'Usuário removido do banco de dados' do
      expect( User.find_by(id: user.id) ).to be_nil
    end
  end

end