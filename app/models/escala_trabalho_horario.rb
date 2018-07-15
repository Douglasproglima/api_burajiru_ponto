class EscalaTrabalhoHorario < ApplicationRecord
  belongs_to :escala_trabalho

  validates_presence_of :descricao, :hora_inicio, :hora_fim, :escala_trabalho_id
end
