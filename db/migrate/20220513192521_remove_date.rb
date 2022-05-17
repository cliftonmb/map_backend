class RemoveDate < ActiveRecord::Migration[7.0]
  def change
    remove_column :activities, :date
  end
end
