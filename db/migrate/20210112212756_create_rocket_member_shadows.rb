class CreateRocketMemberShadows < ActiveRecord::Migration[5.2]
  def change
    create_table :rocket_member_shadows do |t|
      t.timestamps

      t.references :pokemon, foreign_key: true
      t.references :rocket_member, foreign_key: true
    end
  end
end
