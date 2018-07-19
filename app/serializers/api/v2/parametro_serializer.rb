class Api::V2::ParametroSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  belongs_to :empresa
  belongs_to :escala_trabalho
end
