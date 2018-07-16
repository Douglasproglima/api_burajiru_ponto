class Api::V1::DiaPontosController < ApplicationController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    dia_pontos = current_user.dia_pontos
    render json: { dia_pontos: dia_pontos }, status: 200
  end

  def show
    dia_ponto = current_user.dia_pontos.find(params[:id])
    render json: dia_ponto, status: 200
  end

  def create
    dia_ponto = current_user.dia_pontos.build(dia_ponto_params)

    if dia_ponto.save
      render json: dia_ponto, status: 201
    else
      render json: { errors: dia_ponto.errors }, status: 422
    end
  end

  def update
    dia_ponto = current_user.dia_pontos.find(params[:id])

    if dia_ponto.update_attributes(dia_ponto_params)
      render json: dia_ponto, status: 200
    else
      render json: { errors: dia_ponto.errors }, status: 422
    end
  end

  def destroy
    dia_ponto = current_user.dia_pontos.find(params[:id])
    dia_ponto.destroy
    head 204
  end

  private
  def dia_ponto_params
    params.require(:dia_ponto).permit(:data, :user_id, :parametro_id)
  end
end