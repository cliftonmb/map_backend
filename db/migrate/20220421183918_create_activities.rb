class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :address
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
