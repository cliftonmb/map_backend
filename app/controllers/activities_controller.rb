class ActivitiesController < ApplicationController

  def index
    activity = Activity.all
    render json: activity
  end

  def create 
    activity = Activity.new(
      name: params[:name],
      address: params[:address],
    )
    activity.latitude = activity.latitude.as_json(methods: [:latitude])
    activity.longitude = activity.longitude.as_json(methods: [:longitude])
    activity.save
    render json: activity
  end

end
