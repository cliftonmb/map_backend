class AddTwitterYoutubeHomepageInstagram < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :twitter, :string
    add_column :activities, :youtube, :string
    add_column :activities, :homepage, :string
    add_column :activities, :instagram, :string
  end
end
