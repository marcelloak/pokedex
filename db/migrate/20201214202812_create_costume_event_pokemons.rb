class CreateCostumeEventPokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :costume_event_pokemons do |t|
      t.string :method

      t.timestamps

      t.references :costume, foreign_key: true
      t.references :event_timeline, foreign_key: true
    end
  end
end
