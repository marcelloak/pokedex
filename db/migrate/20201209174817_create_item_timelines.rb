class CreateItemTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :item_timelines do |t|
      t.string :name
      t.datetime :released

      t.timestamps
    end
  end
end
