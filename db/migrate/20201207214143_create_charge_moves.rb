class CreateChargeMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :charge_moves do |t|
      t.string :name
      t.integer :damage
      t.integer :energy
      t.string :effect
      t.integer :pve_damage
      t.integer :pve_energy
      t.float :pve_seconds

      t.timestamps

      t.references :type, foreign_key: true 
    end
  end
end
