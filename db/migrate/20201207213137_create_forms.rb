class CreateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :forms do |t|
      t.string :name
      t.integer :attack
      t.integer :defence
      t.integer :stamina

      t.timestamps

      t.references :pokemon, foreign_key: true
      t.references :evolves_from
      t.references :primary_type
      t.references :secondary_type
    end
  end
end
