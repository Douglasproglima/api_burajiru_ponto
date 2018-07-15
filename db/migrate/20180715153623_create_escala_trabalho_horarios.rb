class CreateEscalaTrabalhoHorarios < ActiveRecord::Migration[5.0]
  def change
    create_table :escala_trabalho_horarios do |t|
      t.string :descricao
      t.time :hora_inicio
      t.time :hora_fim
      t.references :escala_trabalho, foreign_key: true

      t.timestamps
    end
  end
end
