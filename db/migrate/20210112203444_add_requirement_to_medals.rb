class AddRequirementToMedals < ActiveRecord::Migration[5.2]
  def change
    add_column :medals, :requirement, :string
  end
end
