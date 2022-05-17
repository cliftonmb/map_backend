class AddDateAgain < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :date, :string
  end
end
