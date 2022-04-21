class ActivitiesController < ApplicationController

  def index
    activity = Activity.first
    render json: activity.latitude
  end

end
