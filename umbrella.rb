require "open-uri"
require "json"

google_api_key = "AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"
dark_sky_key = "26f63e92c5006b5c493906e7953da893"

puts "Where are you located?"
user_location = gets.chomp


puts "Checking the weather for #{user_location}..."


gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{google_api_key}"
dark_sky_url = "https://api.darksky.net/forecast/#{dark_sky_key}"


# location lookup
tempfile = URI.open(gmaps_api_url)
raw_gmaps_data = tempfile.read

parsed_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parsed_gmaps_data.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")
loc = geo.fetch("location")
lat = loc.fetch("lat")
lng = loc.fetch("lng")


# weather lookup using location
dark_sky_fetch_url = "#{dark_sky_url}/#{lat},#{lng}"

dark_sky_data = URI.open(dark_sky_fetch_url).read
parsed_dark_sky_data = JSON.parse(dark_sky_data)


temp = parsed_dark_sky_data.fetch("currently").fetch("temperature")
summary = parsed_dark_sky_data.fetch("currently").fetch("summary")

# final output
puts "Your coordinates are #{lat}, #{lng}"
puts "It is currently #{temp}°F and #{summary.downcase}."
