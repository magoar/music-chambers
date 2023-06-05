class CreateMusicianRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :musician_requirements do |t|
      t.references :musician, null: false, foreign_key: true
      t.references :requirement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
