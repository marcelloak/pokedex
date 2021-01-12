class CreateCandies < ActiveRecord::Migration[5.2]
  def change
    create_table :candies do |t|
      t.integer :held

      t.timestamps

      t.references :family, foreign_key: true
    end
  end
end
