require_relative 'spot_scrape'


# Seed file will spots from a CSV file of spots :names to run scraper on

# SPOT model
# name, latitude, longitude, spot_id, subregion_id

scrap_surfline_spot_id(location_human_to_query("sebastian inlet")) # TODO: interpolate search value
@spot_id = get_id_location(@url_spot_id)
puts @spot_id


scrap_surfline_subregion_id(@url_spot_id)
@subregion_id = get_id_location(@url_subregion_id)
puts @subregion_id
