class AddRehearsalsPerGroupToFestivals < ActiveRecord::Migration[7.0]
  def change
    add_column :festivals, :rehearsals_per_group, :integer
  end
end
