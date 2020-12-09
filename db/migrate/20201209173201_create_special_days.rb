class CreateSpecialDays < ActiveRecord::Migration[5.2]
  def change
    create_table :special_days do |t|
      t.datetime :date

      t.timestamps

      t.references :special_day_type, foreign_key: true
      t.references :pokemon, foreign_key: true
    end
  end
end
