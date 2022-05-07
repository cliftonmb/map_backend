class AddLngLonToMarkers < ActiveRecord::Migration[7.0]
  def change
    add_column :markers, :latitude, :decimal, precision: 10, scale: 6
    add_column :markers, :longitude, :decimal, precision: 10, scale: 6
  end
end
