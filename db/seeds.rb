require_relative 'spot_scrape'


# <<---- Spot seeds ---->>

spot_names = %w[ pipeline jaws trestles ]

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

  if new_spot.save
    puts "#{new_spot.name} saved"
  else
    puts "#{new_spot.name} not saved"
  end
end

# <<---- User seeds ---->>
user1 = User.new(email: "chris_test@lewagon.com", username: "chris_test", password: "123456", location: "Florida")
if user1.save
  puts "#{user1.username} saved"
else
  puts "#{user1.errors.messages}"
end



# <<---- Preference seeds ---->>
preset1 = Preference.new(name: "Rookie", pref_unit: "ft", swell_hgt_min: 1, swell_hgt_max: 4, swell_int_min: 6, swell_int_max: 10, swell_dir_min: 70, swell_dir_max: 80, wind_str_min: 4, wind_str_max: 8, wind_dir_min: 270, wind_dir_max: 290, pref_tide_position: "low", pref_tide_range: 1 )
preset1.user = user1
if preset1.save
  puts "#{preset1.name} preference was saved"
else
  puts"#{preset1.name} preference was not saved"
end

preset2 = Preference.new(name: "Experienced", pref_unit: "ft", swell_hgt_min: 2, swell_hgt_max: 5, swell_int_min: 6, swell_int_max: 12, swell_dir_min: 70, swell_dir_max: 80, wind_str_min: 4, wind_str_max: 8, wind_dir_min: 270, wind_dir_max: 290, pref_tide_position: "low", pref_tide_range: 2 )
preset2.user = user1
if preset2.save
  puts "#{preset2.name} preference was saved"
else
  puts"#{preset2.name} preference was not saved"
end

preset3 = Preference.new(name: "God Mode", pref_unit: "ft", swell_hgt_min: 6, swell_hgt_max: 12, swell_int_min: 10, swell_int_max: 14, swell_dir_min: 70, swell_dir_max: 80, wind_str_min: 4, wind_str_max: 8, wind_dir_min: 270, wind_dir_max: 290, pref_tide_position: "low", pref_tide_range: 3 )
preset3.user = user1
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
