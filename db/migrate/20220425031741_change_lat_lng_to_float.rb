class ChangeLatLngToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :latitude, :float
    change_column :activities, :longitude, :float
  end
end
