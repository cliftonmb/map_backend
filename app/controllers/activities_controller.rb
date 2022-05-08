class ActivitiesController < ApplicationController
  def index
    # activities = Activity.where(id: (1..5).to_a)
    activities = Activity.all
    render json: activities
  end

  def show
    activity = Activity.find_by(id: params[:id])
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

    marker = Marker.new(
      activities_id: activity.id,
      activities_address: activity.address
    )
  end

end
