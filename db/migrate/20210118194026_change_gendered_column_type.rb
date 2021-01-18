class ChangeGenderedColumnType < ActiveRecord::Migration[5.2]
  def change
    def up
      Pokemon.all.each do |pokemon|
        if pokemon[:gendered] == 'MF'
          pokemon[:gendered_tmp] = 0
        elsif pokemon[:gendered] == 'M'
          pokemon[:gendered_tmp] = 1
        elsif pokemon[:gendered] == 'F'
          pokemon[:gendered_tmp] = 2
        else
          pokemon[:gendered_tmp] = 3
        end
        pokemon.save
      end

      change_column :pokemons, :gendered, :integer
    end
    def down
      Pokemon.all.each do |pokemon|
        if pokemon[:gendered] == 0
          pokemon[:gendered_tmp] = 'MF'
        elsif pokemon[:gendered] == 1
          pokemon[:gendered_tmp] = 'M'
        elsif pokemon[:gendered] == 2
          pokemon[:gendered_tmp] = 'F'
        else
          pokemon[:gendered_tmp] = 'GL'
        end
        pokemon.save
      end

      change_column :pokemons, :gendered, :string
    end
  end
end
