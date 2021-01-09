class AlterColumnsInCostumes < ActiveRecord::Migration[5.2]
  def change
    add_column :costumes, :gender_variant, :boolean
    remove_column :costumes, :attack
    remove_column :costumes, :defence
    remove_column :costumes, :stamina
  end
end
