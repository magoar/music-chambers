class CreateRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :requirements do |t|
      t.string :name

      t.timestamps
    end
  end
end
