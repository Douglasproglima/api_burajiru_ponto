class Api::V2::PontosController < ApplicationController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    pontos = current_user.pontos
    render json: pontos.order('id DESC'), status: 200
  end

  def show
    ponto = current_user.pontos.find(params[:id])
    render json: ponto, status: 200
  end

  def create
    ponto = current_user.pontos.build(ponto_params)

    if ponto.save
      render json: ponto, status: 201
    else
      render json: { errors: ponto.errors }, status: 422
    end
  end

  def update
    ponto = current_user.pontos.find(params[:id])

    if ponto.update_attributes(ponto_params)
      render json: ponto, status: 200
    else
      render json: { errors: ponto.errors }, status: 422
    end
  end

  def destroy
    ponto = current_user.pontos.find(params[:id])
    ponto.destroy
    head 204
  end

  private
  def ponto_params
    params.require(:ponto).permit(:hora_inicio, :hora_fim, :user_id, :dia_ponto_id)
  end
end