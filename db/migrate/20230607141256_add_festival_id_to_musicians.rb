class AddFestivalIdToMusicians < ActiveRecord::Migration[7.0]
  def change
    add_reference :musicians, :festival, null: false, foreign_key: true
  end
end
