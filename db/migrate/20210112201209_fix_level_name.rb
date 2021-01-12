class FixLevelName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pokemon_levels, :level, :name
  end
end
