require_relative 'spot_scrape'


# SPOT model
# name, latitude, longitude, spot_id, subregion_id

spot_names = %w[ pipeline jaws trestles]

spot_names.each do |name|
  new_spot = Spot.new(name: name)

  url_spot_id = scrap_surfline_spot_id(location_human_to_query("#{name}")) # TODO: interpolate search value
  spot_id = get_id_location(url_spot_id)
  new_spot.surfline_spot = spot_id


  url_subregion_id = scrap_surfline_subregion_id(url_spot_id)
  subregion_id = get_id_location(url_subregion_id)
  new_spot.surfline_subregion = subregion_id

  wind_json = call_wind_api(spot_id)
  new_spot.latitude = wind_json["associated"]["location"]["lat"]
  new_spot.longitude = wind_json["associated"]["location"]["lon"]
  # wave_json = call_wave_api(spot_id)
  # tide_json = call_tide_api(spot_id)
  # condition_json = call_condition_api(subregion_id)

  puts new_spot.valid? ? "#{new_spot.name} this would save" : "#{new_spot.name} this would not save"
end

# url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
# spot_id = get_id_location(url_spot_id)


# wind_json = call_wind_api(spot_id)
# puts wind_json["associated"]["location"]["lat"]
# puts wind_json["associated"]["location"]["lon"]
