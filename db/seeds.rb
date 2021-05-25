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

preset1 = Preference.new(name: "Rookie", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "Rookie", pref_wind_strength: "Rookie", pref_wind_direction: "Rookie", pref_tide_position: "Rookie", pref_tide_range: "Rookie" )
preset2 = Preference.new(name: "Experienced", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "Experienced", pref_wind_strength: "Experienced", pref_wind_direction: "Experienced", pref_tide_position: "Experienced", pref_tide_range: "Experienced" )
preset3 = Preference.new(name: "God Mode", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "God Mode", pref_wind_strength: "God Mode", pref_wind_direction: "God Mode", pref_tide_position: "God Mode", pref_tide_range: "God Mode" )
