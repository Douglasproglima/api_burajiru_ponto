class Api::V1::ParametrosController < ApplicationController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    parametros = current_user.parametros
    render json: { parametros: parametros }, status: 200
  end

  def show
    parametro = current_user.parametros.find(params[:id])
    render json: parametro, status: 200
  end

  def create
    parametro = current_user.parametros.build(parametro_params)

    if parametro.save
      render json: parametro, status: 201
    else
      render json: { errors: parametro.errors }, status: 422
    end
  end

  def update
    parametro = current_user.parametros.find(params[:id])

    if parametro.update_attributes(parametro_params)
      render json: parametro, status: 200
    else
      render json: { errors: parametro.errors }, status: 422
    end
  end

  def destroy
    parametro = current_user.parametros.find(params[:id])
    parametro.destroy
    head 204
  end

  private
  def parametro_params
    params.require(:parametro).permit(:user_id, :empresa_id, :escala_trabalho_id)
  end
end
