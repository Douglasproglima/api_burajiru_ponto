class Api::V2::EscalaTrabalhoSerializer < ActiveModel::Serializer
  attributes :id, :descricao, :obs, :created_at, :updated_at

  belongs_to :empresa
  # belongs_to :user
  # has_many :user
end
