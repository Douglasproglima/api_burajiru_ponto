class Api::V2::PontoSerializer < ActiveModel::Serializer
  attributes :id, :hora_inicio, :hora_fim, :created_at, :updated_at

  belongs_to :dia_ponto
end
