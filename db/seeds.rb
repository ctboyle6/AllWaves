require_relative 'spot_scrape'


# <<---- Spot seeds ---->>

# spot_names = %w[ pipeline jaws trestles ]

# spot_names.each do |name|
#   new_spot = Spot.new(name: name)

#   url_spot_id = scrap_surfline_spot_id(location_human_to_query("#{name}")) # TODO: interpolate search value
#   spot_id = get_id_location(url_spot_id)
#   new_spot.surfline_spot = spot_id


#   url_subregion_id = scrap_surfline_subregion_id(url_spot_id)
#   subregion_id = get_id_location(url_subregion_id)
#   new_spot.surfline_subregion = subregion_id

#   wind_json = call_wind_api(spot_id)
#   new_spot.latitude = wind_json["associated"]["location"]["lat"]
#   new_spot.longitude = wind_json["associated"]["location"]["lon"]

#   if new_spot.save
#     puts "#{new_spot.name} saved"
#   else
#     puts "#{new_spot.name} not saved"
#   end
# end

# <<---- User seeds ---->>



# <<---- Preference seeds ---->>
preset1 = Preference.new(name: "Rookie", pref_unit: "ft", pref_swell_height: 1, pref_swell_int: 8, pref_swell_direction: 70, pref_wind_strength: 4, pref_wind_direction: 270, pref_tide_position: "low", pref_tide_range: 1 )
if preset1.save
  puts "#{preset1.name} preference was saved"
else
  puts"#{preset1.name} preference was not saved"
end

preset2 = Preference.new(name: "Experienced", pref_unit: "ft", pref_swell_height: 3, pref_swell_int: 10, pref_swell_direction: 70, pref_wind_strength: 6, pref_wind_direction: 270, pref_tide_position: "low", pref_tide_range: 2 )
if preset2.save
  puts "#{preset2.name} preference was saved"
else
  puts"#{preset2.name} preference was not saved"
end

preset3 = Preference.new(name: "God Mode", pref_unit: "ft", pref_swell_height: 8, pref_swell_int: 12, pref_swell_direction: 70, pref_wind_strength: 10, pref_wind_direction: 270, pref_tide_position: "low", pref_tide_range: 3 )
if preset3.save
  puts "#{preset3.name} preference was saved"
else
  puts"#{preset3.name} preference was not saved"
end

# << tests >>
# url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
# spot_id = get_id_location(url_spot_id)

# << API JSON retrieves >>
# wind_json = call_wind_api(spot_id)
# wave_json = call_wave_api(spot_id)
# tide_json = call_tide_api(spot_id)
# condition_json = call_condition_api(subregion_id)
