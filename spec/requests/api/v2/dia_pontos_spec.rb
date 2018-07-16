require 'rails_helper'

RSpec.describe 'Dia Ponto API' do

  #HOST's
  # before { host! 'api.burajiru_ponto.dev' } //Não está funcionando com esse host
  # before { host! 'api.burajiru_ponto.test' } //Não está funcionando com esse host
  before { host! 'api.localhost.dev' }

  let!(:user) { create(:user) }
  let!(:parametro) {create(:parametros)}
  let(:headers) do
    {
        'Accept' => 'application/vnd.burajiru_ponto.v2',
        'Content-Type' => Mime[:json].to_s,
        'Authorization' => user.auth_token
    }
  end

  #Verbo GET
  describe 'GET /dia_pontos' do
    before do
      create_list(:dia_ponto, 1, user_id: user.id)
      get '/dia_pontos', params: {}, headers: headers
    end

    #Os Testes
    context 'Quando for retornado dados salvos' do
      it 'Retorna o código status: 200 OK' do
        expect(response).to have_http_status(200)
      end

      #espera que o json_body retorne 5 dia_pontos do banco de dados
      it 'Retorna as 5 dia_pontos criadas do banco de dados' do
        expect(json_body[:data].count).to eq(1)
      end
    end

    context 'Quando for enviado um parâmetro na requisição ou ordenação' do
      let!(:hoje_dia_ponto_1){ create(:dia_ponto, data: '2018-07-17 08:00:00', user_id: user.id, parametro_id: 1) }
      let!(:semanaQueVem_dia_ponto_1){ create(:dia_ponto, data: '2018-07-23 08:00:00', user_id: user.id, parametro_id: 1) }
      let!(:semanaQueVem_dia_ponto_1){ create(:dia_ponto, data: '2018-07-24 08:00:00', user_id: user.id, parametro_id: 1) }
      let!(:semanaQueVem_dia_ponto_1){ create(:dia_ponto, data: '2018-07-25 08:00:00', user_id: user.id, parametro_id: 1) }

      before do
        get "/dia_pontos?q[data_gteq_any]='2018-07-22'&q[s]=data+DESC", params: { }, headers: headers

        # get '/dia_pontos?', params: { q: {data_gteq_any: '2018-07-22'} }, headers: headers
      end

      it 'Retornar os registros que atendam o filtro' do
        resultado_dia_ponto_data = json_body[:data].map{ |t| t[:attributes][:data] }

        expect(resultado_dia_ponto_data).to eq([semanaQueVem_dia_ponto_3, semanaQueVem_dia_ponto_2, semanaQueVem_dia_ponto_1])
      end
    end
  end

  describe 'GET /dia_pontos/:id' do
    let(:dia_ponto){ create(:dia_ponto, user_id: user.id) }

    before { get "/dia_pontos/#{dia_ponto.id}", params: {}, headers: headers }

    it 'Retorna o código status: 200 OK' do
      expect(response).to have_http_status(200)
    end

    it 'Retorna a dia_ponto em JSON' do
      expect(json_body[:data][:attributes][:data]).to eq(dia_ponto.data)
    end
  end

  #Verbo POST
  describe 'POST /dia_pontos' do
    before do
      post '/dia_pontos', params: { dia_ponto: dia_ponto_params }.to_json, headers: headers
    end

    context 'Quando os parâmetros são válidos' do

      let(:dia_ponto_params) { attributes_for(:dia_ponto) }

      it 'Retorna o código status: 201 - Registro Criado.' do
        expect(response).to have_http_status(201)
      end

      it 'Salvar registro no banco de dados' do
        expect( DiaPonto.find_by(data: dia_ponto_params[:data]) ).not_to be_nil
      end

      it 'Retorna o JSON com o registro criado' do
        expect(json_body[:data][:attributes][:data]).to eq(dia_ponto_params[:data])
      end

      it 'Verifica se foi relacionado o usuário corrente a dia_ponto criada' do
        expect(json_body[:data][:attributes][:'user-id']).to eq(user.id)
      end
    end

    context 'Quando os parâmetros são inválidos' do
      let(:dia_ponto_params) { attributes_for(:dia_ponto, data: ' ') }

      it 'Retorna o código status: 422' do
        expect(response).to have_http_status(422)
      end

      it 'Não foi salvo o registro no banco de dados' do
        expect( DiaPonto.find_by(data: dia_ponto_params[:data]) ).to be_nil
      end

      it 'Retornar o JSON com o erro referente ao atributo razao_social' do
        expect(json_body[:errors]).to have_key(:razao_social)

      end
    end
  end

  #Verbo PUT
  describe 'PUT /dia_pontos' do
    let!(:dia_ponto) { create(:dia_ponto, user_id: user.id) }

    before do
      put "/dia_pontos/#{dia_ponto.id}", params: { dia_ponto: dia_ponto_params }.to_json, headers: headers
    end

    context 'Parâmetros válidos' do
      let(:dia_ponto_params){{ data: 'Nova dia_ponto' }}

      it 'Retorna o código status: 200 - Registro Criado' do
        expect(response).to have_http_status(200)
      end

      it 'Retorna o JSON com o registro atualizado' do
        expect(json_body[:data][:attributes][:data]).to eq(dia_ponto_params[:data])
      end

      it 'Atualiza registro no banco de dados' do
        expect( DiaPonto.find_by(data: dia_ponto_params[:data]) ).not_to be_nil
      end
    end

    context 'Parâmetros inválidos' do
      let(:dia_ponto_params) { attributes_for(:dia_ponto, data: ' ') }

      it 'Retorna o código status: 422' do
        expect(response).to have_http_status(422)
      end

      it 'Retornar o JSON com o erro referente ao atributo razao_social' do
        expect(json_body[:errors]).to have_key(:data)
      end

      it 'Não foi salvo o registro no banco de dados' do
        expect( DiaPonto.find_by(data: dia_ponto_params[:data]) ).to be_nil
      end
    end
  end

  #Verbo DELETE
  describe 'DELETE /dia_pontos' do
    let!(:dia_ponto) { create(:dia_ponto, user_id: user.id) }

    before do
      delete "/dia_pontos/#{dia_ponto.id}", params: { }, headers: headers
    end

    it 'Retorna o código status: 204 - Registro Removido' do
      expect(response).to have_http_status(204)
    end

    it 'Remove o registro do banco de dados' do
      expect { DiaPonto.find(dia_ponto.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end