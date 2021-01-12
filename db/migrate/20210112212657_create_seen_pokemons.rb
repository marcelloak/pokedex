class CreateSeenPokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :seen_pokemons do |t|
      t.boolean :lucky
      t.string :gender

      t.timestamps

      t.references :pokemon, foreign_key: true
    end
  end
end
