class ChangeGenderedType < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :pokemons, :gendered, :string
    end

    def down
      change_column :pokemons, :gendered, :integer
    end
  end
end
