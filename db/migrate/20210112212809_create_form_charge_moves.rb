class CreateFormChargeMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :form_charge_moves do |t|
      t.boolean :legacy
      t.boolean :elite

      t.timestamps

      t.references :form, foreign_key: true
      t.references :charge_move, foreign_key: true
    end
  end
end
