class CreateGblTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :gbl_timelines do |t|
      t.string :name
      t.datetime :great_start
      t.datetime :great_end
      t.datetime :ultra_start
      t.datetime :ultra_end
      t.datetime :master_start
      t.datetime :master_end
      t.datetime :all_start
      t.datetime :all_end

      t.timestamps
    end
  end
end
