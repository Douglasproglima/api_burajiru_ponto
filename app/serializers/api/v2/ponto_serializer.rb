class Api::V2::PontoSerializer < ActiveModel::Serializer
  attributes :id, :hora_inicio, :hora_inicio_to_br,
             :hora_fim, :hora_fim_to_br, :created_at, :updated_at

  def hora_inicio_to_br
    I18n.l(object.hora_inicio, format: :time_to_br) if object.hora_inicio.present?
  end

  def hora_fim_to_br
    I18n.l(object.hora_fim, format: :time_to_br) if object.hora_fim.present?
  end

  belongs_to :dia_ponto
end
