class Api::V2::EmpresaSerializer < ActiveModel::Serializer
  attributes :id, :ativo, :razao_social, :nome_fantasia, :email, :telefone_1,
             :telefone_2, :vlr_hora, :percentual_hora_extra, :percentual_add_noturno,
             :created_at, :updated_at

  belongs_to :tipo_contrato
end
