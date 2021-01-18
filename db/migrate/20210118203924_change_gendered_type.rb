class ChangeGenderedType < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :pokemons, :gendered, 'integer USING CAST(gendered AS integer)'
    end

    def down

    end
  end
end
