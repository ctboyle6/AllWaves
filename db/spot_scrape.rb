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
  html_doc.search('#surf-spots .result a').first.nil? ? true : html_doc.search('#surf-spots .result a').first.attributes["href"].value
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

def get_tides_variables(timestamp,results)
  filtered_results =  results.select do |result|
    result["timestamp"] < ( timestamp + 3600*3 ) && result["timestamp"] >= timestamp
  end
  filtered_results_high = filtered_results.select {|result| result["type"] == "HIGH" }
  filtered_results_low = filtered_results.select {|result| result["type"] == "LOW" }

  if filtered_results_low.size > 0
    @tide_type = "LOW"
  elsif filtered_results_high.size > 0
    @tide_type = "HIGH"
  else
    @tide_type = "NORMAL"
  end
  filtered_results_high = 0
  filtered_results_low = 0
  filtered_results_tide =  results.find{ |result| result["timestamp"] == timestamp }
  filtered_results_tide.nil? ? filtered_results_tide = []  : @tide_height = filtered_results_tide["height"]
end


# << conditions >>
def call_condition_api(subregion_id_location)
  url = "https://services.surfline.com/kbyg/regions/forecasts/conditions?subregionId=#{subregion_id_location}&days=6"
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
  @utc_offset = wind_json["associated"]["utcOffset"]

  # Get the results in an array of wave objects
  results_wave = wave_json["data"]["wave"]
  # Get the results in an array of tide objects
  results_tide = tide_json["data"]["tides"]
  # Better way to do it
  i = 0
  while i < results_wind.length
    @timestamp = results_wind[i]["timestamp"]
    @wind_strength = results_wind[i]["speed"]
    @wind_direction = results_wind[i]["direction"]
    @wind_gust = results_wind[i]["gust"]
    @wind_optimal_score = results_wind[i]["optimalScore"]
    results_tide = tide_json["data"]["tides"]

    get_tides_variables(@timestamp, results_tide)
    @waves_surf_min = results_wave[i]["surf"]["min"]
    @waves_surf_max = results_wave[i]["surf"]["max"]
    @waves_surf_optimal_score = results_wave[i]["surf"]["optimalScore"]
    # Logic to keep the highest swell
    biggest_swell = 0
    results_wave[i]["swells"].each do |swell|
       
      if swell["height"] > biggest_swell
        biggest_swell = swell["height"]
        @waves_swell_height = biggest_swell
        @waves_swell_period = swell["period"]
        @waves_swell_direction = swell["direction"]
        @waves_swell_direction_min = swell["directionMin"]
        @waves_swell_optimal_score = swell["optimalScore"]
      end
    end
    Condition.create!(
      utc_offset: @utc_offset,
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
      waves_swell_optimal_score: @waves_swell_optimal_score,
    )

    i += 1
  end
end
