class MapboxTokenController < ApplicationController

  def index
    render json: {message: Rails.application.credentials.mapbox_token}
  end

end
