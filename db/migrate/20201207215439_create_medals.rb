class CreateMedals < ActiveRecord::Migration[5.2]
  def change
    create_table :medals do |t|
      t.string :name
      t.integer :bronze
      t.integer :silver
      t.integer :gold
      t.integer :platinum
      t.string :reward

      t.timestamps
    end
  end
end
