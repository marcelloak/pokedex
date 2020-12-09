class CreateSpecialLeagueTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :special_league_timelines do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.integer :max_cp
      t.string :notes

      t.timestamps

      t.references :gbl_timeline, foreign_key: true
    end
  end
end
