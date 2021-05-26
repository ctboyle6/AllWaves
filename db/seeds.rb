require_relative 'spot_scrape'
Spot.destroy_all
User.destroy_all


# <<---- Spot seeds ---->>
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
  p new_spot.save!

  if new_spot.save
    puts "#{new_spot.name} saved"
  else
    puts "#{new_spot.name} not saved"
  end

  # <<---- Conditions seeds ---->>
  puts "Getting conditions..."
  # << Wind >>
  wind_json = call_wind_api(spot_id)

  # << Wave >>
  wave_json = call_wave_api(spot_id)

  # << Tide >>
  tide_json = call_tide_api(spot_id)

  # Get the results in an array of wind objects
  results_wind = wind_json["data"]["wind"]
  # Get the results in an array of wave objects
  results_wave = wave_json["data"]["wave"]
  # Get the results in an array of tide objects
  results_tide = tide_json["data"]["tides"]

  # Keeping the same timestamps
  results_wind.each do |result|
    timestamp = result["timestamp"]
    wind_strength = result["speed"]
    wind_direction = result["direction"]
    wind_gust = result["gust"]
    wind_optimal_score = result["optimalScore"]
    results_wave.each do |result|
      if timestamp == result["timestamp"]
        waves_surf_min = result["surf"]["min"]
        waves_surf_max = result["surf"]["max"]
        waves_surf_optimal_score = result["surf"]["optimalScore"]
        # Logic to keep the highest swell
        biggest_swell = 0
        result["swells"].each do |swell|
          if swell["height"] > biggest_swell
            biggest_swell = swell["height"]
            @waves_swell_height = biggest_swell
            @waves_swell_period = swell["period"]
            @waves_swell_direction = swell["direction"]
            @waves_swell_direction_min = swell["directionMin"]
            @waves_swell_optimal_score = swell["optimalScore"]

          end
        end

        results_tide.each do |result|
          if timestamp == result["timestamp"]
            tide_type = result["type"]
            tide_height = result["height"]

            # Creating the new condition seed
            condition = Condition.create!(
              spot_id: new_spot.id,
              timestamp: timestamp,
              wind_strength: wind_strength,
              wind_direction: wind_direction,
              wind_gust: wind_gust,
              wind_optimal_score: wind_optimal_score,
              waves_surf_min: waves_surf_min,
              waves_surf_max: waves_surf_max,
              waves_optimal_score: waves_surf_optimal_score,
              tide_type: tide_type,
              tide_height: tide_height,
              waves_swell_height: @waves_swell_height,
              waves_swell_period: @waves_swell_period,
              waves_swell_direction: @waves_swell_direction,
              waves_swell_direction_min: @waves_swell_direction_min,
              waves_swell_optimal_score: @waves_swell_optimal_score
            )

          end
        end
      end
    end

  end
  puts "Finished seeding conditions..."
end

# <<---- User seeds ---->>
user1 = User.create!(email: "a@a.a", password:"123456", username:"user1", location: "Miami")
user1 = User.create!(email: "b@b.b", password:"123456", username:"user2", location: "Orlando")
user1 = User.create!(email: "c@c.c", password:"123456", username:"user3", location: "Tallahassee")




# <<---- Preference seeds ---->>
preset1 = Preference.new(name: "Rookie", pref_unit: "FT", swell_hgt_min: 1, swell_hgt_max: 4, swell_int_min: 6, swell_int_max: 10, swell_dir_min: 70, swell_dir_max: 80, wind_str_min: 4, wind_str_max: 8, wind_dir_min: 270, wind_dir_max: 290, pref_tide_position: "Low", pref_tide_range: 1 )
preset1.user = user1
if preset1.save
  puts "#{preset1.name} preference was saved"
else
  puts"#{preset1.name} preference was not saved"
end

preset2 = Preference.new(name: "Experienced", pref_unit: "FT", swell_hgt_min: 2, swell_hgt_max: 5, swell_int_min: 6, swell_int_max: 12, swell_dir_min: 70, swell_dir_max: 80, wind_str_min: 4, wind_str_max: 8, wind_dir_min: 270, wind_dir_max: 290, pref_tide_position: "Low", pref_tide_range: 2 )
preset2.user = user1
if preset2.save
  puts "#{preset2.name} preference was saved"
else
  puts"#{preset2.name} preference was not saved"
end

preset3 = Preference.new(name: "God Mode", pref_unit: "FT", swell_hgt_min: 6, swell_hgt_max: 12, swell_int_min: 10, swell_int_max: 14, swell_dir_min: 70, swell_dir_max: 80, wind_str_min: 4, wind_str_max: 8, wind_dir_min: 270, wind_dir_max: 290, pref_tide_position: "Low", pref_tide_range: 3 )
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

