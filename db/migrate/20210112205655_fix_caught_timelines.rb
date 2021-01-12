class FixCaughtTimelines < ActiveRecord::Migration[5.2]
  def change
    if column_exists?(:pokemon_caught_timelines, :level)
      remove_column :pokemon_caught_timelines, :level
    end
    if column_exists?(:pokemon_caught_timelines, :current_level)
      remove_column :pokemon_caught_timelines, :current_level
    end
    if column_exists?(:pokemon_caught_timelines, :target_level)
      remove_column :pokemon_caught_timelines, :target_level
    end
    remove_column :form_caught_timelines, :current_level
    remove_column :form_caught_timelines, :target_level
    remove_column :costume_caught_timelines, :current_level
    remove_column :costume_caught_timelines, :target_level
  end
end
