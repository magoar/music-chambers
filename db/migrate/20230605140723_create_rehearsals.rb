class CreateRehearsals < ActiveRecord::Migration[7.0]
  def change
    create_table :rehearsals do |t|
      t.date :rehearsal_date
      t.time :start_time
      t.references :festival, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
