class CreateTimeslots < ActiveRecord::Migration[7.0]
  def change
    create_table :timeslots do |t|
      t.time :start_time
      t.time :end_time
      t.references :festival, null: false, foreign_key: true

      t.timestamps
    end
  end
end
