class AddDateAndStartTimeToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :date, :string
    add_column :activities, :start_time, :string
  end
end
