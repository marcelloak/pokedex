class CreateCostumeTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :costume_timelines do |t|
      t.datetime :released
      t.boolean :available
      t.boolean :ignored

      t.timestamps

      t.references :costume, foreign_key: true
    end
  end
end
