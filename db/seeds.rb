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


  results_wind.each do |result|
    @timestamp = result["timestamp"]
    @wind_strength = result["speed"]
    @wind_direction = result["direction"]
    @wind_gust = result["gust"]
    @wind_optimal_score = result["optimalScore"]
    url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
    spot_id = get_id_location(url_spot_id)
    tide_json = call_tide_api(spot_id)
    results_tide = tide_json["data"]["tides"]
    get_tides_variables(@timestamp, results_tide)
    results_wave.each do |result|
      if result["timestamp"] == @timestamp
        @waves_surf_min = result["surf"]["min"]
        @waves_surf_max = result["surf"]["max"]
        @waves_surf_optimal_score = result["surf"]["optimalScore"]
        # Logic to keep the highest swell
        biggest_swell = 0
        result["swells"].each do |swell|
          if swell["height"] > biggest_swell
            @biggest_swell = swell["height"]
            @waves_swell_height = biggest_swell
            @waves_swell_period = swell["period"]
            @waves_swell_direction = swell["direction"]
            @waves_swell_direction_min = swell["directionMin"]
            @waves_swell_optimal_score = swell["optimalScore"]
          end
        end
        results_tide.each do |result|
          if @timestamp == result["timestamp"]
            @tide_height = result["height"]
            Condition.create!(
              spot_id: new_spot.id,
              timestamp: @timestamp,
              wind_strength: @wind_strength,
              wind_direction: @wind_direction,
              wind_gust: @wind_gust,
              wind_optimal_score: @wind_optimal_score,
              waves_surf_min: @waves_surf_min,
              waves_surf_max: @waves_surf_max,
              waves_optimal_score: @waves_surf_optimal_score,
              tide_type: @tide_type,
              tide_height: @tide_height,
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



# <<---- Preference seeds ---->>
preset1 = Preference.new(name: "Rookie", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "Rookie", pref_wind_strength: "Rookie", pref_wind_direction: "Rookie", pref_tide_position: "Rookie", pref_tide_range: "Rookie" )
preset2 = Preference.new(name: "Experienced", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "Experienced", pref_wind_strength: "Experienced", pref_wind_direction: "Experienced", pref_tide_position: "Experienced", pref_tide_range: "Experienced" )
preset3 = Preference.new(name: "God Mode", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "God Mode", pref_wind_strength: "God Mode", pref_wind_direction: "God Mode", pref_tide_position: "God Mode", pref_tide_range: "God Mode" )


# << tests >>
# url_spot_id = scrap_surfline_spot_id(location_human_to_query("pipeline")) # TODO: interpolate search value
# spot_id = get_id_location(url_spot_id)

# << API JSON retrieves >>
# wind_json = call_wind_api(spot_id)
# wave_json = call_wave_api(spot_id)
# tide_json = call_tide_api(spot_id)
# condition_json = call_condition_api(subregion_id)

# <<---- User seeds ---->>
user1 = User.create!(email: "a@a.a", password:"123456", username:"user1", location: "Miami")
user1 = User.create!(email: "b@b.b", password:"123456", username:"user2", location: "Orldando")
user1 = User.create!(email: "c@c.c", password:"123456", username:"user3", location: "tallahassee")