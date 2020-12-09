class CreateFeatureTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :feature_timelines do |t|
      t.string :name
      t.datetime :released

      t.timestamps
    end
  end
end
