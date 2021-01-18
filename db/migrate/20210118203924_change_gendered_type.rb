class ChangeGenderedType < ActiveRecord::Migration[5.2]
  def change
    change_column :pokemons, :gendered, :integer
  end
end
