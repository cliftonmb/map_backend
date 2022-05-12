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
#     event_date = individual_event["dates"]["start"]["localDate"]
#     event_start_time = individual_event["dates"]["start"]["localTime"]
#     event_image = individual_event["images"][0]["url"]
    
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
#         longitude: lat_lng[1],
#         date: event_date,
#         start_time: event_start_time,
#         image_url: event_image
#       )
#       more_details_links = individual_event["_embedded"]["attractions"][0]["externalLinks"]
#       unless more_details_links.nil?
#         unless more_details_links["twitter"].nil?
#           activity.twitter = more_details_links["twitter"][0]["url"]
#         end
#         unless more_details_links["youtube"].nil?
#           activity.youtube = more_details_links["youtube"][0]["url"]
#         end
#         unless more_details_links["instagram"].nil?
#           activity.instagram = more_details_links["instagram"][0]["url"]
#         end
#         unless more_details_links["homepage"].nil?
#           activity.homepage = more_details_links["homepage"][0]["url"]
#         end
#       end
    
#       activity.save
#       event_number += 1
#     end
#   end
#   page += 1
# end

# activities = Activity.where(id: (6..20).to_a)
# activities = Activity.all
# activities.each{|activity|
#   markers = Marker.all
#   if markers.empty? # this is if there are no markers created yet
#     marker = Marker.new(
#     activities_id: activity.id,
#     activities_address: activity.address
#   )
#     marker.save
#     activity.marker_id = marker.id
#     activity.save
  
#   elsif Marker.where(activities_address: activity.address).empty? # this is for if the address is a new address/address doesn't already have a marker
#     marker = Marker.new(
#     activities_id: activity.id,
#     activities_address: activity.address
#     )
#     marker.save
#     activity.marker_id = marker.id
#     activity.save
#   else # this for the new activities whose addresses already have a marker
#     marker = Marker.find_by(activities_address: activity.address)
#     # activity.address == marker.activities_address
#     activity.marker_id = marker.id
#     activity.save
#   end
# }

# markers = Marker.all
# markers.each{|marker|
#   marker.latitude = marker.latitude.as_json(methods: [:latitude])
#   marker.longitude = marker.longitude.as_json(methods: [:longitude])
#   marker.save
# }

# # CONVERT START TIME TO AM/PM
# # activities = Activity.where(id: (6..20).to_a)
# activities = Activity.all
# activities.each{|activity|
#   hours = (activity.start_time[0] + activity.start_time[1]).to_i
#   minutes = (activity.start_time[3] + activity.start_time[4])
  
#   if hours == 0
#     activity.start_time = "12:#{minutes} AM"
#   elsif hours < 12
#     activity.start_time = "#{hours}:#{minutes} AM"
#   else
#     hours -= 12
#     activity.start_time = "#{hours}:#{minutes} PM"
#   end
#   activity.save
# }
# months_names = {
#   "01" => "January",
#   "02" => "February",
#   "03" => "March",
#   "04" => "April",
#   "05" => "May",
#   "06" => "June",
#   "07" => "July",
#   "08" => "August",
#   "09" => "September",
#   "10" => "October",
#   "11" => "November",
#   "12" => "December"
# }

# # activities = Activity.where(id: (6..20).to_a)
# # activities = Activity.all
# activities.each{|activity|
#   month = activity.date[5] + activity.date[6]
#   day = (activity.date[8] + activity.date[9]).to_i
#   year = activity.date[0] + activity.date[1] + activity.date[2] + activity.date[3]
#   activity.date = "#{months_names[month]} #{day}, #{year}"
#   activity.save
# }

####################################
# 1. get channel id from "Channel by Username"
# 2. Playlist player by "channel ID"

activities = Activity.all
activities.each{|activity|
  if activity.youtube.nil?
    nil
  else
    # p activity.id
    if activity.youtube.include? "user"
      youtube_username = ""
      index = -1
      until activity.youtube[index] == "/"
        youtube_username << activity.youtube[index]
        index -= 1
      end
      youtube_username.reverse!
      ### Channel by username
      channel_by_username = HTTP.get("https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&forUsername=#{youtube_username}&key=#{Rails.application.credentials.google_api_key} ")
      channel_by_username = channel_by_username.parse(:json)
      channel_id = channel_by_username["items"][0]["id"]

      ### Playlist player by channel ID
      playlist_player_by_channel_id = HTTP.get("https://youtube.googleapis.com/youtube/v3/playlists?part=player&channelId=#{channel_id}&key=#{Rails.application.credentials.google_api_key}")
      playlist_player_by_channel_id = playlist_player_by_channel_id.parse(:json)
      activity.youtube = playlist_player_by_channel_id["items"][1]["player"]["embedHtml"]
      activity.save
    else
      channel_id = ""
      index = -1
      until activity.youtube[index] == "/"
        channel_id << activity.youtube[index]
        index -= 1
      end
      channel_id.reverse!
      ### Playlist player by channel ID
      playlist_player_by_channel_id = HTTP.get("https://youtube.googleapis.com/youtube/v3/playlists?part=player&channelId=#{channel_id}&key=#{Rails.application.credentials.google_api_key}")
      playlist_player_by_channel_id = playlist_player_by_channel_id.parse(:json)
      activity.youtube = playlist_player_by_channel_id["items"][1]["player"]["embedHtml"]
      activity.save
    end
  end
}