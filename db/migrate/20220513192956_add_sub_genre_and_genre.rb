class AddSubGenreAndGenre < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :genre, :string 
    add_column :activities, :sub_genre, :string
  end
end
