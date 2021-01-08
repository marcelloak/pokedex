class AddDefaultToForms < ActiveRecord::Migration[5.2]
  def change
    add_column :forms, :default, :boolean
  end
end
