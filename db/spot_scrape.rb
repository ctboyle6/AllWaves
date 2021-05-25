require 'csv'
require 'open-uri'
require 'nokogiri'


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
  @url_spot_id = html_doc.search('#surf-spots .result a').first.attributes["href"].value
end

scrap_surfline_spot_id(location_human_to_query("sebastian inlet")) # TODO: interpolate search value
@spot_id = get_id_location(@url_spot_id)
puts @spot_id




# <---- get subregionID ---->
def scrap_surfline_subregion_id(url_spot_id)
  html_file = URI.open(url_spot_id).read
  html_doc = Nokogiri::HTML(html_file)
  @url_subregion_id = html_doc.search(".sl-forecast-header__nav__page-level__link").first.attributes["href"].value
end

scrap_surfline_subregion_id(@url_spot_id)
@subregion_id = get_id_location(@url_subregion_id)
puts @subregion_id




# @conditions_info = conditions_infos_api(@subregion_id)

# call Wave API
# @waves_infos = waves_infos_api(@spot_id)

# call Tide API
# @tides_infos = tides_infos_api(@spot_id)




# def tides_infos_api(spot_id_location)
#   url = "https://services.surfline.com/kbyg/spots/forecasts/tides?spotId=#{spot_id_location}&days=1"
#   puts url
#   tides_serialized = URI.open(url).read
#   JSON.parse(tides_serialized)
# end

# def waves_infos_api(spot_id_location)
#   url = "https://services.surfline.com/kbyg/spots/forecasts/wave?spotId=#{spot_id_location}&days=1&intervalHours=24&maxHeights=false"
#   # puts url
#   waves_serialized = URI.open(url).read
#   JSON.parse(waves_serialized)
# end











# # write to csv

# csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
# filepath    = 'spots.csv'

# CSV.open(filepath, 'wb', csv_options) do |csv|
#   # csv << ['Name', 'Appearance', 'Origin']
#   # csv << ['Asahi', 'Pale Lager', 'Japan']
#   # csv << ['Guinness', 'Stout', 'Ireland']
# end
