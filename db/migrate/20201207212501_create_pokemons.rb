class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :number
      t.integer :attack
      t.integer :defence
      t.integer :stamina
      t.integer :buddy_distance
      t.integer :evolve_candy
      t.boolean :trade_discount
      t.string :evolve_requirement
      t.boolean :gender_variant
      t.boolean :legendary
      t.boolean :mythical
      t.string :gendered
      t.string :region

      t.timestamps

      t.references :evolves_from
      t.references :generation, foreign_key: true 
      t.references :family, foreign_key: true 
      t.references :primary_type
      t.references :secondary_type
    end
  end
end
