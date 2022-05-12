class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    favorites = Favorite.where(user_id: current_user.id)
    activities = Activity.all
    favorited_activities = []
    favorites.each{|favorite|
      favorited_activity = activities.where(id: favorite.activity_id)
      favorited_activities << favorited_activity
    }
    render json: favorited_activities
  end

  def create
    favorite = Favorite.new(
      activity_id: params[:activity_id],
      user_id: current_user.id
    )
    favorite.save
    render json: favorite
  end


  def destroy
    favorite = Favorite.find_by(activity_id: params[:id])
    favorite.delete
    render json: {message: "Removed from favorites"}
  end
end
   