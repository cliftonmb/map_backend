class ChangeActivityToActivities < ActiveRecord::Migration[7.0]
  def change
    rename_column :markers, :activity_id, :activities_id    
    rename_column :markers, :activity_address, :activities_address    
  end
end
