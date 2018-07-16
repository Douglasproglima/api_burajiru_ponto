class Ponto < ApplicationRecord
  belongs_to :user
  belongs_to :dia_ponto

  validates_presence_of :hora_inicio, :user_id, :dia_ponto_id
end
