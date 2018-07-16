class CreatePontos < ActiveRecord::Migration[5.0]
  def change
    create_table :pontos do |t|
      t.time :hora_inicio
      t.time :hora_fim
      t.references :user, foreign_key: true
      t.references :dia_ponto, foreign_key: true

      t.timestamps
    end
  end
end
