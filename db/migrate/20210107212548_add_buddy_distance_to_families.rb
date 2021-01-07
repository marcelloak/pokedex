class AddBuddyDistanceToFamilies < ActiveRecord::Migration[5.2]
  def change
    add_column :families, :buddy_distance, :integer
  end
end
