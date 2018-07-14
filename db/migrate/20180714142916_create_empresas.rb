class CreateEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.boolean :ativo, default: true
      t.string :razao_social
      t.string :nome_fantasia
      t.string :email
      t.string :telefone_1
      t.string :telefone_2
      t.decimal :vlr_hora, precision: 10, scale: 2, default: 0
      t.integer :percentual_hora_extra, default: 0
      t.integer :percentual_add_noturno, default: 0
      t.references :tipo_contrato, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
