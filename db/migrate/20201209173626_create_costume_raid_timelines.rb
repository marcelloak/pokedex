class CreateCostumeRaidTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :costume_raid_timelines do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps

      t.references :costume, foreign_key: true
    end
  end
end
