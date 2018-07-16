require 'rails_helper'

RSpec.describe 'Empresas API' do

  #HOST's
  # before { host! 'api.burajiru_ponto.dev' } //Não está funcionando com esse host
  # before { host! 'api.burajiru_ponto.test' } //Não está funcionando com esse host
  before { host! 'api.localhost.dev' }

  let!(:user) { create(:user) }  #cria o usuário
  let(:headers) do
    {
        'Accept' => 'application/vnd.burajiru_ponto.v2',
        'Content-Type' => Mime[:json].to_s,
        'Authorization' => user.auth_token
    }
  end

  #Verbo GET
  describe 'GET /empresas' do
    before do

      # create_list(:entidade, numero_registros_que_vao_ser_criados, entidade_relacionada linha 5)
      create_list(:empresa, 1, user_id: user.id)
      get '/empresas', params: {}, headers: headers
    end

    #Os Testes
    it 'Retorna o código status: 200 OK' do
      expect(response).to have_http_status(200)
    end

    #espera que o json_body retorne 5 empresas do banco de dados
    it 'Retorna as 5 empresas criadas do banco de dados' do
      # expect(json_body[:empresas].count).to eq(1)
      expect(json_body[:data].count).to eq(1)
    end
  end

  describe 'GET /empresas/:id' do
    let(:empresa){ create(:empresa, user_id: user.id) }

    before { get "/empresas/#{empresa.id}", params: {}, headers: headers }

    it 'Retorna o código status: 200 OK' do
      expect(response).to have_http_status(200)
    end

    #espera que o json_body retorne 5 empresas do banco de dados
    it 'Retorna a empresa em JSON' do
      expect(json_body[:data][:attributes][:razao_social]).to eq(empresa.razao_social)
    end
  end

  #Verbo POST
  describe 'POST /empresas' do
    before do
      post '/empresas', params: { empresa: empresa_params }.to_json, headers: headers
    end

    context 'Quando os parâmetros são válidos' do

      let(:empresa_params) { attributes_for(:empresa) }

      it 'Retorna o código status: 201 - Registro Criado.' do
        expect(response).to have_http_status(201)
      end

      it 'Salvar registro no banco de dados' do
        expect( Empresa.find_by(razao_social: empresa_params[:razao_social]) ).not_to be_nil #empresa_params[:razao_social]).count ).to eq(1)
      end

      it 'Retorna o JSON com o registro criado' do
        expect(json_body[:data][:attributes][:razao_social]).to eq(empresa_params[:razao_social])
      end

      it 'Verifica se foi relacionado o usuário corrente a empresa criada' do
        expect(json_body[:data][:attributes][:'user-id']).to eq(user.id)
      end
    end

    context 'Quando os parâmetros são inválidos' do
      let(:empresa_params) { attributes_for(:empresa, razao_social: ' ') } #Passando o atributo razao_social vázio

      it 'Retorna o código status: 422' do
        expect(response).to have_http_status(422)
      end

      it 'Não foi salvo o registro no banco de dados' do
        expect( Empresa.find_by(razao_social: empresa_params[:razao_social]) ).to be_nil #Espera que seja null
      end

      it 'Retornar o JSON com o erro referente ao atributo razao_social' do
        # expect(json_body).to have_key(:errors) #Verifica se há erros no geral

        #Verifica se há erro no array :errors referente ao atributo razao_social
        expect(json_body[:errors]).to have_key(:razao_social)

      end
    end
  end

  #Verbo PUT
  describe 'PUT /empresas' do
    let!(:empresa) { create(:empresa, user_id: user.id) }

    before do
      put "/empresas/#{empresa.id}", params: { empresa: empresa_params }.to_json, headers: headers
    end

    context 'Parâmetros válidos' do
      let(:empresa_params){{ razao_social: 'Nova Empresa' }}

      it 'Retorna o código status: 200 - Registro Criado' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna o JSON com o registro atualizado' do
        expect(json_body[:data][:attributes][:razao_social]).to eq(empresa_params[:razao_social])
      end

      it 'Atualiza registro no banco de dados' do
        expect( Empresa.find_by(razao_social: empresa_params[:razao_social]) ).not_to be_nil
      end
    end

    context 'Parâmetros inválidos' do
      let(:empresa_params) { attributes_for(:empresa, razao_social: ' ') } #Passando o atributo razao_social vázio

      it 'Retorna o código status: 422' do
        expect(response).to have_http_status(422)
      end

      it 'Retornar o JSON com o erro referente ao atributo razao_social' do
        expect(json_body[:errors]).to have_key(:razao_social)
      end

      it 'Não foi salvo o registro no banco de dados' do
        expect( Empresa.find_by(razao_social: empresa_params[:razao_social]) ).to be_nil #Espera que seja null
      end
    end
  end

  #Verbo DELETE
  describe 'DELETE /empresas' do
    let!(:empresa) { create(:empresa, user_id: user.id) }

    before do
      delete "/empresas/#{empresa.id}", params: { }, headers: headers
    end

    it 'Retorna o código status: 204 - Registro Removido' do
      expect(response).to have_http_status(204)
    end

    it 'Remove o registro do banco de dados' do
      expect { Empresa.find(empresa.id) }.to raise_error(ActiveRecord::RecordNotFound)
      # expect { Empresa.find_by(id: empresa.id).to be_nil
    end
  end
end