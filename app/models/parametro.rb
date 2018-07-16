class Parametro < ApplicationRecord
  belongs_to :user
  belongs_to :empresa
  belongs_to :escala_trabalho

  has_many :dia_pontos, dependent: :destroy

  validates_presence_of :user_id, :empresa_id, :escala_trabalho_id
end
