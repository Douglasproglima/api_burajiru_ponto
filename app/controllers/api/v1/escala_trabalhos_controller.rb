class Api::V1::EscalaTrabalhosController < Api::V1::BaseController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    escala_trabalhos = current_user.escala_trabalhos
    render json: { escala_trabalhos: escala_trabalhos }, status: 200
  end

  def show
    escala_trabalho = current_user.escala_trabalhos.find(params[:id])
    render json: escala_trabalho, status: 200
  end

  def create
    escala_trabalho = current_user.escala_trabalhos.build(escala_trabalho_params)

    if escala_trabalho.save
      render json: escala_trabalho, status: 201
    else
      render json: { errors: escala_trabalho.errors }, status: 422
    end
  end

  def update
    escala_trabalho = current_user.escala_trabalhos.find(params[:id])

    if escala_trabalho.update_attributes(escala_trabalho_params)
      render json: escala_trabalho, status: 200
    else
      render json: { errors: escala_trabalho.errors }, status: 422
    end
  end

  def destroy
    escala_trabalho = current_user.escala_trabalhos.find(params[:id])
    escala_trabalho.destroy
    head 204
  end

  private
  def escala_trabalho_params
    params.require(:escala_trabalho).permit(:ativo, :descricao, :obs, :user_id, :empresa_id)
  end
end
