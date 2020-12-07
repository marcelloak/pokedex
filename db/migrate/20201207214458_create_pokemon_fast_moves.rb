class CreatePokemonFastMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemon_fast_moves do |t|
      t.boolean :legacy
      t.boolean :elite

      t.timestamps

      t.references :pokemon, foreign_key: true
      t.references :fast_move, foreign_key: true
    end
  end
end
