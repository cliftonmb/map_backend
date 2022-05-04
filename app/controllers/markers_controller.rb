class MarkersController < ApplicationController

  def index
    markers = Marker.all
    render json: markers
  end

  def show
    marker = Marker.find_by(id: params[:id])
    render json: marker
  end

  def create
    
    activities = Activity.all
    
    activities.each{|activity|
      markers = Marker.all
      if markers.empty?
        marker = Marker.new(
        activities_id: activity.id,
        activities_address: activity.address
        )
        marker.save
        activity.marker_id = marker.id
        activity.save
      elsif activity.address == marker.activities_address
        activity.marker_id = marker.id
      else
        marker = Marker.new(
        activities_id: activity.id,
        activities_address: activity.address
        )
        marker.save
        activity.marker_id = marker.id
        activity.save
      end
    }
    # render json: markers
  end

end
