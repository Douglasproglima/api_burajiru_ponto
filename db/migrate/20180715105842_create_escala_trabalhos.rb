class CreateEscalaTrabalhos < ActiveRecord::Migration[5.0]
  def change
    create_table :escala_trabalhos do |t|
      t.string :descricao
      t.text :obs
      t.boolean :ativo, default: true
      t.references :user, foreign_key: true
      t.references :empresa, foreign_key: true

      t.timestamps
    end
  end
end
