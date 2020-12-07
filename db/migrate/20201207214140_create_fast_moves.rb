class CreateFastMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :fast_moves do |t|
      t.string :name
      t.integer :turns
      t.integer :damage
      t.integer :energy
      t.integer :pve_damage
      t.integer :pve_energy
      t.float :pve_seconds

      t.timestamps

      t.references :type, foreign_key: true 
    end
  end
end
