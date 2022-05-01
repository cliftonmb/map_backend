class ChangeLatLngToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :latitude, :decimal
    change_column :activities, :longitude, :decimal
  end
end
