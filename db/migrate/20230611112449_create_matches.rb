class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :first_team, null: false, foreign_key: { to_table: :teams }
      t.references :second_team, null: false, foreign_key: { to_table: :teams }
      t.integer :first_team_score
      t.integer :second_team_score
      t.string :name

      t.timestamps
    end
  end
end
