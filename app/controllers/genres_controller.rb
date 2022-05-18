class GenresController < ApplicationController

  def index
    activities = Activity.all
    genres = []
    sub_genres = []
    activities.each{|activity|
      genres << activity.genre
      sub_genres << activity.sub_genre
    }
    render json: {genres: genres.uniq, sub_genres: sub_genres.uniq}
  end

end
