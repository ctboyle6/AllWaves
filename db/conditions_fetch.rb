require_relative 'spot_scrape'

# puts "Enter a location :"

# name = gets.chomp

url_spot_id = scrap_surfline_spot_id(location_human_to_query("miami")) # TODO: interpolate search value
spot_id = get_id_location(url_spot_id)
# new_spot.surfline_spot = spot_id


url_subregion_id = scrap_surfline_subregion_id(url_spot_id)
subregion_id = get_id_location(url_subregion_id)

# << Wind >>
wind_json = call_wind_api(spot_id)

# << Wave >>
wave_json = call_wave_api(spot_id)

# << Tide >>
tide_json = call_tide_api(spot_id)

# << conditions >>
condition_json = call_condition_api(subregion_id)

# Get the results in an array of wind objects
results_wind = wind_json["data"]["wind"]
# Get the results in an array of wave objects
results_wave = wave_json["data"]["wave"]
# Get the results in an array of tide objects
results_tide = tide_json["data"]["tides"]

# Conditions_json

results_wind.each do |r|
  pp r
end




