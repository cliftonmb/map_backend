class AddDatesArray < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :dates, :text, array: true, default: []
  end
end
