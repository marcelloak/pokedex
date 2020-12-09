class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.datetime :started
      t.integer :level

      t.timestamps
    end
  end
end
