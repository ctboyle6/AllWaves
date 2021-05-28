require_relative 'spot_scrape'
require_relative 'conditions_fetch'



# <<---- Spot seeds ---->>
spot_names = %w[ pipeline jaws trestles ]
spot_names.each do |name|
  puts "Creating new spot names..."
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
    puts "#{new_spot.name.capitalize} has been saved"
  else
    puts "#{new_spot.name.capitalize} was not saved"
  end

  # <<---- Conditions seeds ---->>
  puts "Getting conditions..."

  create_condition(new_spot,spot_id)

  puts "Finished seeding conditions..."
end

# <<---- User seeds ---->>
user1 = User.create!(email: "a@a.a", password:"123456", username:"user1", location: "Miami")


# <<---- Preference seeds ---->>
preset1 = Preference.new(name: "Rookie", pref_unit: "FT", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "LOW", pref_tide_range: 1 )
preset1.user = user1
if preset1.save
  puts "#{preset1.name} preference was saved"
else
  puts"#{preset1.name} preference was not saved"
end

preset2 = Preference.new(name: "Mediocre", pref_unit: "FT", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "NORMAL", pref_tide_range: 2 )
preset2.user = user1
if preset2.save
  puts "#{preset2.name} preference was saved"
else
  puts"#{preset2.name} preference was not saved"
end

preset3 = Preference.new(name: "Advanced", pref_unit: "FT", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "HIGH", pref_tide_range: 3 )
preset3.user = user1
if preset3.save
  puts "#{preset3.name} preference was saved"
else
  puts"#{preset3.name} preference was not saved"
end

UserSpot.create(user: user1, spot: Spot.last)

# << tests >>
# url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
# spot_id = get_id_location(url_spot_id)

# << API JSON retrieves >>
# wind_json = call_wind_api(spot_id)
# wave_json = call_wave_api(spot_id)
# tide_json = call_tide_api(spot_id)
# condition_json = call_condition_api(subregion_id)

