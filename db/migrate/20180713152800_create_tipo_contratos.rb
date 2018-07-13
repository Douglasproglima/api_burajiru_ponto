class CreateTipoContratos < ActiveRecord::Migration[5.0]
  def change
    create_table :tipo_contratos do |t|
      t.string :descricao
      t.text :obs
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
