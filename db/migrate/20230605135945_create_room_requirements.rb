class CreateRoomRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :room_requirements do |t|
      t.references :room, null: false, foreign_key: true
      t.references :requirement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
