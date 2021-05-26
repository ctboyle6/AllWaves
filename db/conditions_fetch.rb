require_relative 'spot_scrape'

# puts "Enter a location :"

# name = gets.chomp

url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
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
pp results_wind = wind_json["data"]["wind"].length
# Get the results in an array of wave objects
pp results_wave = wave_json["data"]["wave"].length
# Get the results in an array of tide objects
pp results_tide = tide_json["data"]["tides"].length

# Conditions_json

# results_wind.each do |result|
#   timestamp = result["timestamp"]
#   wind_strength = result["speed"]
#   wind_direction = result["direction"]
#   wind_gust = result["gust"]
#   wind_optimal_score = result["optimalScore"]
#   results_wave.each do |result|
#     if timestamp == result["timestamp"]
#       waves_surf_min = result["surf"]["min"]
#       waves_surf_max = result["surf"]["max"]
#       waves_surf_optimal_score = result["surf"]["optimalScore"]
#     end
#     results_tide.each do |result|
#       if timestamp == result["timestamp"]
#         pp tide_type = result["type"]
#         pp tide_height = result["height"]
#         # Creating the new condition seed
#       end
#     end
#   end
  
# end