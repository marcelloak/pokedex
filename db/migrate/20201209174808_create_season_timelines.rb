class CreateSeasonTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :season_timelines do |t|
      t.string :name
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
