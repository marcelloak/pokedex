class AddForeignKeyToFamilies < ActiveRecord::Migration[5.2]
  def change
    add_reference(:families, :generation, foreign_key: true)
  end
end
