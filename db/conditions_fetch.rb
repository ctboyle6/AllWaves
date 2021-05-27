# require_relative 'spot_scrape'

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
results_wind = wind_json["data"]["wind"]
# Get the results in an array of wave objects
results_wave = wave_json["data"]["wave"]
# Get the results in an array of tide objects
results_tide = tide_json["data"]["tides"]


# # Get all wind variables
# def get_wind_variables(results)
#   results.each do |result|
#     timestamp = result["timestamp"]
#     @wind_strength = result["speed"]
#     @wind_direction = result["direction"]
#     @wind_gust = result["gust"]
#     @wind_optimal_score = result["optimalScore"]
#     url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
#     spot_id = get_id_location(url_spot_id)
#     tide_json = call_tide_api(spot_id)
#     results_tide = tide_json["data"]["tides"]
#     get_tides_variables(timestamp, results_tide)
#   end
# end

# # Get all waves variables
# def get_waves_variables(results)
#   results.each do |result|
#     @waves_surf_min = result["surf"]["min"]
#     @waves_surf_max = result["surf"]["max"]
#     @waves_surf_optimal_score = result["surf"]["optimalScore"]
#     # Logic to keep the highest swell
#     biggest_swell = 0
#     result["swells"].each do |swell|
#       if swell["height"] > biggest_swell
#         @biggest_swell = swell["height"]
#         @waves_swell_height = biggest_swell
#         @waves_swell_period = swell["period"]
#         @waves_swell_direction = swell["direction"]
#         @waves_swell_direction_min = swell["directionMin"]
#         @waves_swell_optimal_score = swell["optimalScore"]
#       end
#     end
#   end
# end


# def get_tides_variables(timestamp,results)
#   filtered_results =  results.select do |result| 
#     result["timestamp"] < ( timestamp + 3600*3 ) && result["timestamp"] >= timestamp
#   end
#   filtered_results_high = filtered_results.select {|result| result["type"] == "HIGH" }
#   filtered_results_low = filtered_results.select {|result| result["type"] == "LOW" }

#   if filtered_results_low.size > 0
#     @tide_type = "LOW"
#   elsif filtered_results_high.size > 0
#     @tide_type = "HIGH"
#   else 
#     @tide_type = "NORMAL"
#   end
#   filtered_results_high = 0
#   filtered_results_low = 0
# end
