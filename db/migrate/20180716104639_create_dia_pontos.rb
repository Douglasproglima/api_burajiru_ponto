class CreateDiaPontos < ActiveRecord::Migration[5.0]
  def change
    create_table :dia_pontos do |t|
      t.datetime :data
      t.references :user, foreign_key: true
      t.references :parametro, foreign_key: true

      t.timestamps
    end
  end
end
