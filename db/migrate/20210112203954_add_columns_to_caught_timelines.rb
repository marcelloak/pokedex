class AddColumnsToCaughtTimelines < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemon_caught_timelines, :raider, :boolean
    add_column :form_caught_timelines, :raider, :boolean
    add_column :costume_caught_timelines, :raider, :boolean
    add_column :pokemon_caught_timelines, :defender, :boolean
    add_column :form_caught_timelines, :defender, :boolean
    add_column :costume_caught_timelines, :defender, :boolean
    add_column :pokemon_caught_timelines, :pvp, :string
    add_column :form_caught_timelines, :pvp, :string
    add_column :costume_caught_timelines, :pvp, :string
  end
end
