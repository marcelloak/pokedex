class CreatePokemonLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemon_levels do |t|
      t.float :level
      t.integer :stardust
      t.integer :candy
      t.integer :candy_xl
      t.float :cp_multiplier

      t.timestamps
    end
  end
end
