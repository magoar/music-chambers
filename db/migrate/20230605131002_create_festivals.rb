class CreateFestivals < ActiveRecord::Migration[7.0]
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :slots_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
