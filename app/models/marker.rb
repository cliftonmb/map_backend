class Marker < ApplicationRecord
  def latitude
    results = Geocoder.search("#{activities_address},Chicago,Illinois,United States")
    latitude = results.first.coordinates[0]
  end
  
  def longitude
    results = Geocoder.search("#{activities_address},Chicago,Illinois,United States")
    longitude = results.first.coordinates[1]
  end
end
