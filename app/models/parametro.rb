class Parametro < ApplicationRecord
  belongs_to :user
  belongs_to :empresa
  belongs_to :escala_trabalho

  validates_presence_of :user_id, :empresa_id, :escala_trabalho_id
end
