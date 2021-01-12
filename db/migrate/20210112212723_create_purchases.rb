class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.datetime :purchased
      t.integer :coins
      t.boolean :ticket
      t.boolean :box
      t.integer :price

      t.timestamps
    end
  end
end
