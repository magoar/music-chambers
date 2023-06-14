class RemoveSlotsPerDayFromFestivals < ActiveRecord::Migration[7.0]
  def change
    remove_column :festivals, :slots_per_day, :integer
  end
end
