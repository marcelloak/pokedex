class ChangePvpType < ActiveRecord::Migration[5.2]
  def change
    FormCaughtTimeline.all.each do |form|
      if form[:pvp] == 'Great'
        form[:pvp] = 0
      elsif form[:pvp] == 'Ultra'
        form[:pvp] = 1
      elsif form[:pvp] == 'Master'
        form[:pvp] = 2
      else
        form[:pvp] = 3
      end
      form.save
    end

    change_column :form_caught_timelines, :pvp, :integer, using: 'pvp::integer'

    CostumeCaughtTimeline.all.each do |costume|
      if costume[:pvp] == 'Great'
        costume[:pvp] = 0
      elsif costume[:pvp] == 'Ultra'
        costume[:pvp] = 1
      elsif costume[:pvp] == 'Master'
        costume[:pvp] = 2
      else
        costume[:pvp] = 3
      end
      costume.save
    end

    change_column :costume_caught_timelines, :pvp, :integer, using: 'pvp::integer'

    PokemonCaughtTimeline.all.each do |pokemon|
      if pokemon[:pvp] == 'Great'
        pokemon[:pvp] = 0
      elsif pokemon[:pvp] == 'Ultra'
        pokemon[:pvp] = 1
      elsif pokemon[:pvp] == 'Master'
        pokemon[:pvp] = 2
      else
        pokemon[:pvp] = 3
      end
      pokemon.save
    end

    change_column :pokemon_caught_timelines, :pvp, :integer, using: 'pvp::integer'
  end
end
