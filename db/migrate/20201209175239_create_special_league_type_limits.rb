class CreateSpecialLeagueTypeLimits < ActiveRecord::Migration[5.2]
  def change
    create_table :special_league_type_limits do |t|
      t.timestamps

      t.references :special_league_timeline, foreign_key: true
      t.references :type, foreign_key: true
    end
  end
end
