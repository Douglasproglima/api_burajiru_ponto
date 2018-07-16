class Api::V2::EscalaTrabalhoHorariosController < ApplicationController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    escala_trabalho_horarios = EscalaTrabalhoHorario.order('id DESC')
    render json: escala_trabalho_horarios, status: 200
  end

  #Criar método para passar o id pai(id escala) e retornar todos os horários relacionados.
  # def horariosEscala
  #   begin
  #     escala_trabalho_horario = EscalaTrabalhoHorario.escala_trabalho_id.find(params[:id])
  #     render json: escala_trabalho_horario, status: 200
  #   rescue
  #     head 404
  #   end
  # end

  def show
    begin
      escala_trabalho_horario = EscalaTrabalhoHorario.find(params[:id])
      render json: escala_trabalho_horario, status: 200
    rescue
      head 404
    end
  end

  def create
    escala_trabalho_horario = EscalaTrabalhoHorario.new(escala_trabalho_horario_params)

    if escala_trabalho_horario.save
      render json: escala_trabalho_horario, status: 201
    else
      render json: { errors: escala_trabalho_horario.errors }, status: 422
    end
  end

  def update
    escala_trabalho_horario = EscalaTrabalhoHorario.find(params[:id])

    if escala_trabalho_horario.update_attributes(escala_trabalho_horario_params)
      render json: escala_trabalho_horario, status: 200
    else
      render json: { errors: escala_trabalho_horario.errors }, status: 422
    end
  end

  def destroy
    escala_trabalho_horario = EscalaTrabalhoHorario.find(params[:id])
    escala_trabalho_horario.destroy
    head 204
  end

  private
  def escala_trabalho_horario_params
    params.require(:escala_trabalho_horario).permit(:descricao, :hora_inicio.to_t, :hora_fim.to_t, :escala_trabalho_id)
  end
end