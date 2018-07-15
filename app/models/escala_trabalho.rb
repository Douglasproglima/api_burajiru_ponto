class EscalaTrabalho < ApplicationRecord
  belongs_to :user
  belongs_to :empresa

  has_many :escala_trabalho_horarios, dependent: :destroy

  validates_presence_of :ativo, :descricao, :user_id, :empresa_id
end
