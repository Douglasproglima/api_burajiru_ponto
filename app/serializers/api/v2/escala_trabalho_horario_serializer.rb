class Api::V2::EscalaTrabalhoHorarioSerializer < ActiveModel::Serializer
  attributes :id, :descricao, :hora_inicio, :hora_fim, :created_at, :updated_at

  belongs_to :escala_trabalho
end
