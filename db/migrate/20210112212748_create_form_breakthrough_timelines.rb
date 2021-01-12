class CreateFormBreakthroughTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :form_breakthrough_timelines do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps

      t.references :form, foreign_key: true
    end
  end
end
