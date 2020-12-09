class CreateMedalTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :medal_timelines do |t|
      t.datetime :released

      t.timestamps

      t.references :medal, foreign_key: true
    end
  end
end
