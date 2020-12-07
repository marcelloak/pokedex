class CreateTypeInteractions < ActiveRecord::Migration[5.2]
  def change
    create_table :type_interactions do |t|
      t.float :multiplier

      t.timestamps

      t.references :attacking_type
      t.references :defending_type
    end
  end
end
