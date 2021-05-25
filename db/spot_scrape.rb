# required modules to scrape and write csv

require 'csv'
require 'open-uri'
require 'nokogiri'

# scrape logic

# ingredient = 'chocolate'
# url = "https://www.bbcgoodfood.com/search/recipes?q=#{ingredient}"

# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search('.standard-card-new__article-title').each do |element|
#   puts element.text.strip
#   puts element.attribute('href').value
# end


# <---- get spotID ---->
def get_id_location(url)
  regex = /[^\/]+$/
  url.match(regex)
end

def scrap_surfline_spot_id(location)
  search_url = "https://www.surfline.com/search/#{location}"
  html_file = URI.open(search_url).read
  html_doc = Nokogiri::HTML(html_file)
  @url_spot_id = html_doc.search('#surf-spots .result a').first.attributes["href"].value
end

scrap_surfline_spot_id("pipeline") # TODO: interpolate search value
@spot_id = get_id_location(@url_spot_id)



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
