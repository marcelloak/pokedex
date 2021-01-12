class CreateRocketMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :rocket_members do |t|
      t.string :name

      t.timestamps
    end
  end
end
