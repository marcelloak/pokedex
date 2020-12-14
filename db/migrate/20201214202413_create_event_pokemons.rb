class CreateEventPokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :event_pokemons do |t|
      t.string :method

      t.timestamps

      t.references :pokemon, foreign_key: true
      t.references :event_timeline, foreign_key: true
    end
  end
end
