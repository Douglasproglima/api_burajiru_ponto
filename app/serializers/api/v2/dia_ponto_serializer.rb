class Api::V2::DiaPontoSerializer < ActiveModel::Serializer
  attributes :id, :data, :data_to_br, :created_at, :updated_at

  def data_to_br
    I18n.l(object.data, format: :datetime) if object.data.present?
  end

  belongs_to :parametro
end
