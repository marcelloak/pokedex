class CreateSpecialDayTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :special_day_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
