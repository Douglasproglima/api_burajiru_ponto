class Api::V1::EmpresasController < ApplicationController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    empresas = current_user.empresas
    render json: { empresas: empresas }, status: 200
  end

  def show
    empresa = current_user.empresas.find(params[:id]) #Encontra as empresas do usuário corrente
    render json: empresa, status: 200
  end

  def create
    empresa = current_user.empresas.build(empresa_params)

    if empresa.save
      render json: empresa, status: 201
    else
      render json: { errors: empresa.errors }, status: 422
    end
  end

  def update
    empresa = current_user.empresas.find(params[:id])

    if empresa.update_attributes(empresa_params)
      render json: empresa, status: 200
    else
      render json: { errors: empresa.errors }, status: 422
    end
  end

  def destroy
    empresa = current_user.empresas.find(params[:id])
    empresa.destroy
    head 204
  end

  private
  def empresa_params
    params.require(:empresa).permit(:ativo, :razao_social, :nome_fantasia, :email, :telefone_1, :telefone_2, :vlr_hora, :percentual_hora_extra, :percentual_add_noturno, :user_id, :tipo_contrato_id)
  end
end
