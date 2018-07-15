class EscalaTrabalho < ApplicationRecord
  belongs_to :user
  belongs_to :empresa

  validates_presence_of :ativo, :descricao, :user_id, :empresa_id
end
