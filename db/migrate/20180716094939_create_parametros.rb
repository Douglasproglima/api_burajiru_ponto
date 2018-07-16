class CreateParametros < ActiveRecord::Migration[5.0]
  def change
    create_table :parametros do |t|
      t.references :user, foreign_key: true
      t.references :empresa, foreign_key: true
      t.references :escala_trabalho, foreign_key: true

      t.timestamps
    end
  end
end
