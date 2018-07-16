class Api::V2::DiaPontoSerializer < ActiveModel::Serializer
  attributes :id, :data, :created_at, :updated_at

  belongs_to :parametro
end
