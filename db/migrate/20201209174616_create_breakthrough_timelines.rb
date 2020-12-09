class CreateBreakthroughTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :breakthrough_timelines do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps

      t.references :pokemon, foreign_key: true
    end
  end
end
