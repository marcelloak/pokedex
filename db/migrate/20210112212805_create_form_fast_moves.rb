class CreateFormFastMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :form_fast_moves do |t|
      t.boolean :legacy
      t.boolean :elite

      t.timestamps

      t.references :form, foreign_key: true
      t.references :fast_move, foreign_key: true
    end
  end
end
