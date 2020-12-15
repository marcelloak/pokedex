class CreateFormCaughtTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :form_caught_timelines do |t|
      t.datetime :caught
      t.integer :attack
      t.integer :defence
      t.integer :stamina
      t.float :current_level
      t.float :target_level
      t.string :gender
      t.boolean :shadow
      t.boolean :purified
      t.boolean :shiny
      t.boolean :lucky
      t.boolean :charge_move_unlocked
      t.datetime :transferred

      t.timestamps

      t.references :current_form
      t.references :target_form
      t.references :fast_move, foreign_key: true
      t.references :first_charge_move
      t.references :second_charge_move
      t.references :original_owner
      t.references :current_owner

      t.timestamps
    end
  end
end
