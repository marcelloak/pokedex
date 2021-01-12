class AlterColumnsInCaughtTimelines < ActiveRecord::Migration[5.2]
  def change
    add_reference(:pokemon_caught_timelines, :current_level, foreign_key: {to_table: :pokemon_levels})
    add_reference(:form_caught_timelines, :current_level, foreign_key: {to_table: :pokemon_levels})
    add_reference(:costume_caught_timelines, :current_level, foreign_key: {to_table: :pokemon_levels})
    add_reference(:pokemon_caught_timelines, :target_level, foreign_key: {to_table: :pokemon_levels})
    add_reference(:form_caught_timelines, :target_level, foreign_key: {to_table: :pokemon_levels})
    add_reference(:costume_caught_timelines, :target_level, foreign_key: {to_table: :pokemon_levels})

    add_column :pokemon_caught_timelines, :high_iv, :boolean
    add_column :form_caught_timelines, :high_iv, :boolean
    add_column :costume_caught_timelines, :high_iv, :boolean
  end
end
