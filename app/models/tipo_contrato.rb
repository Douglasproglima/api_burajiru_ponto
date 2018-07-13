class TipoContrato < ApplicationRecord
  belongs_to :user

  validates_presence_of :descricao, :user_id
end
