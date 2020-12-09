class CreateShinyFormTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :shiny_form_timelines do |t|
      t.datetime :released
      t.boolean :available
      t.boolean :ignored

      t.timestamps

      t.references :form, foreign_key: true
    end
  end
end
