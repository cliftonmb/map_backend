# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

page = 1
while page <= 49
  event_number = 0
  response = HTTP.get("https://app.ticketmaster.com/discovery/v2/events.json?city=chicago&apikey=cYjcLquUvmfEx3jvx8BAwbcBfS7MpIxk&page=#{page}")
  20.times do

    events = response.parse(:json)
    # p events

    # add [name] to get the name of event, event number can be from 0 to 19
    individual_event = events["_embedded"]["events"][event_number]

    # 0 must remain always
    event_address = individual_event["_embedded"]["venues"][0]["address"]["line1"]

    
    # geocoder lat/lng format is [latitude, longitude]
    results = Geocoder.search("#{event_address},Chicago,Illinois,United States")
    if results.empty?
      event_number += 1
    else
      lat_lng = results.first.coordinates
      activity = Activity.new(
        name: individual_event["name"],
        address: event_address,
        latitude: lat_lng[0],
        longitude: lat_lng[1]
      )
      activity.save
      event_number += 1
    end
  end
  page += 1
end