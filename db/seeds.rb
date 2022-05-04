# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# page = 0
# while page <= 0
#   event_number = 0
#   response = HTTP.get("https://app.ticketmaster.com/discovery/v2/events.json?city=chicago&apikey=#{Rails.application.credentials.ticketmaster_api_key}&page=#{page}")
#   20.times do

#     events = response.parse(:json)
#     # p events

#     # add [name] to get the name of event, event number can be from 0 to 19
#     individual_event = events["_embedded"]["events"][event_number]

#     # 0 must remain always
#     event_address = individual_event["_embedded"]["venues"][0]["address"]["line1"]

    
#     # geocoder lat/lng format is [latitude, longitude]
#     results = Geocoder.search("#{event_address},Chicago,Illinois,United States")
#     if results.empty?
#       event_number += 1
#     else
#       lat_lng = results.first.coordinates
#       activity = Activity.new(
#         name: individual_event["name"],
#         address: event_address,
#         latitude: lat_lng[0],
#         longitude: lat_lng[1]
#       )
#       activity.save
#       event_number += 1
#     end
#   end
#   page += 1
# end

activities = Activity.where(id: (6..20).to_a)

activities.each{|activity|
  markers = Marker.all
  if markers.empty? # this is if there are no markers created yet
    marker = Marker.new(
    activities_id: activity.id,
    activities_address: activity.address
  )
    marker.save
    activity.marker_id = marker.id
    activity.save
  
  elsif Marker.where(activities_address: activity.address).empty? # this is for if the address is a new address/address doesn't already have a marker
    marker = Marker.new(
    activities_id: activity.id,
    activities_address: activity.address
    )
    marker.save
    activity.marker_id = marker.id
    activity.save
  else # this for the new activities whose addresses already have a marker
    marker = Marker.find_by(activities_address: activity.address)
    # activity.address == marker.activities_address
    activity.marker_id = marker.id
    activity.save
  end
}