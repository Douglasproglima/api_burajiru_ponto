class TipoContrato < ApplicationRecord
  belongs_to :user

  has_many :empresas, dependent: :destroy

  validates_presence_of :descricao, :user_id
end
