class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :pokemons, :gendered, :integer, using: 'gendered::integer'
  end
end
