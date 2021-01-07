class RemoveBuddyDistanceFromPokemons < ActiveRecord::Migration[5.2]
  def change
    remove_column :pokemons, :buddy_distance
  end
end
