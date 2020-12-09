class CreateCostumes < ActiveRecord::Migration[5.2]
  def change
    create_table :costumes do |t|
      t.string :name
      t.integer :attack
      t.integer :defence
      t.integer :stamina

      t.timestamps

      t.references :pokemon, foreign_key: true
    end
  end
end
