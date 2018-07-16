class Api::V2::TipoContratosController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    tipo_contratos = current_user.tipo_contratos
    # tipo_contratos = TipoContrato.all()
    render json: tipo_contratos.order('id DESC'), status: 200
  end

  def show
    tipo_contrato = current_user.tipo_contratos.find(params[:id])
    render json: tipo_contrato, status: 200
  end

  def create
    tipo_contrato = current_user.tipo_contratos.build(tipo_contrato_params)

    if tipo_contrato.save
      render json: tipo_contrato, status: 201
    else
      render json: { errors: tipo_contrato.errors }, status: 422
    end
  end

  def update
    tipo_contrato = current_user.tipo_contratos.find(params[:id])

    if tipo_contrato.update_attributes(tipo_contrato_params)
      render json: tipo_contrato, status: 200
    else
      render json: { errors: tipo_contrato.errors }, status: 422
    end
  end

  def destroy
    tipo_contrato = current_user.tipo_contratos.find(params[:id])
    tipo_contrato.destroy
    head 204
  end

  private
  def tipo_contrato_params
    params.require(:tipo_contrato).permit(:descricao, :obs)
  end
end
