class CreateSpecialResearchTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :special_research_timelines do |t|
      t.string :name
      t.datetime :released
      t.boolean :timed
      t.integer :price

      t.timestamps
    end
  end
end
