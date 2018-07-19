class Api::V2::TipoContratoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :descricao, :obs, :created_at, :updated_at,
             :descricao_resumida, :is_alterado

  def descricao_resumida
    object.descricao[0..10] if object.updated_at.present?
  end

  def is_alterado
    object.updated_at > object.created_at if object.updated_at.present?
  end

  # belongs_to :user
end
