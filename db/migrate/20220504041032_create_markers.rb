class CreateMarkers < ActiveRecord::Migration[7.0]
  def change
    create_table :markers do |t|
      t.integer :activity_id
      t.string :activity_address

      t.timestamps
    end
  end
end
