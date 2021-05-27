require 'csv'
require 'open-uri'
require 'nokogiri'
require 'json'

# <---- search helper methods ---->
def get_id_location(url)
  regex = /[^\/]+$/
  url.match(regex)
end

def location_human_to_query(params_location)
  array = []
  query = ""
  array = params_location.split(" ")
  array.map do |element|
    query += "%20#{element}"
  end

  query
end


# <---- get spotID ---->
def scrap_surfline_spot_id(location)
  search_url = "https://www.surfline.com/search/#{location}"
  html_file = URI.open(search_url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('#surf-spots .result a').first.attributes["href"].value
end


# <---- get subregionID ---->
def scrap_surfline_subregion_id(url_spot_id)
  html_file = URI.open(url_spot_id).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search(".sl-forecast-header__nav__page-level__link").first.attributes["href"].value
end


# <---- call Surfline APIs (spot) ---->
# << Wave >>
def call_wave_api(spot_id_location)
  url = "https://services.surfline.com/kbyg/spots/forecasts/wave?spotId=#{spot_id_location}&days=6&intervalHours=3&maxHeights=false"
  waves_serialized = URI.open(url).read
  JSON.parse(waves_serialized)
end


# << Wind >>
def call_wind_api(spot_id_location)
  url = "https://services.surfline.com/kbyg/spots/forecasts/wind?spotId=#{spot_id_location}&days=6&intervalHours=3&sds=true"
  winds_serialized = URI.open(url).read
  JSON.parse(winds_serialized)
end


# << Tide >>
def call_tide_api(spot_id_location)
  url = "https://services.surfline.com/kbyg/spots/forecasts/tides?spotId=#{spot_id_location}&days=6&intervalHours=3"
  tides_serialized = URI.open(url).read
  JSON.parse(tides_serialized)
end



# << conditions >>
def call_condition_api(subregion_id_location)
  url = "https://services.surfline.com/kbyg/regions/forecasts/conditions?subregionId=#{subregion_id_location}&days=1"
  conditions_serialized = URI.open(url).read
  JSON.parse(conditions_serialized)
end

def create_condition(new_spot,spot_id)
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
end
