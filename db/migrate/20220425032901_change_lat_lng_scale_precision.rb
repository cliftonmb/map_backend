class ChangeLatLngScalePrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :latitude, :decimal, precision: 10, scale: 6
    change_column :activities, :longitude, :decimal, precision: 10, scale: 6
  end
end
