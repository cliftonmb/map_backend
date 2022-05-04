class AddMarkerIdToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :marker_id, :integer
  end
end
