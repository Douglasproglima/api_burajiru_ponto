class Empresa < ApplicationRecord
  belongs_to :tipo_contrato
  belongs_to :user

  has_many :escala_trabalhos, dependent: :destroy

  validates_presence_of :ativo, :razao_social, :email, :telefone_1, :vlr_hora, :percentual_hora_extra, :percentual_add_noturno, :user_id, :tipo_contrato_id
end
