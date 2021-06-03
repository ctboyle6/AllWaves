require_relative 'spot_scrape'
require_relative '../app/mailers/sms_sender'
require 'twilio-ruby'

# <<---- Spot seeds ---->>
spot_names = %w[ pipeline jaws trestles]
spot_names.each do |name|
  puts "Creating new spot names..."
  new_spot = Spot.new(name: name)

  url_spot_id = scrap_surfline_spot_id(location_human_to_query("#{name}"))
  spot_id = get_id_location(url_spot_id)
  new_spot.surfline_spot = spot_id


  url_subregion_id = scrap_surfline_subregion_id(url_spot_id)
  subregion_id = get_id_location(url_subregion_id)
  new_spot.surfline_subregion = subregion_id

  wind_json = call_wind_api(spot_id)
  new_spot.latitude = wind_json["associated"]["location"]["lat"]
  new_spot.longitude = wind_json["associated"]["location"]["lon"]
  new_spot.utc_offset = wind_json["associated"]["utcOffset"]

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
stephfoo = User.create!(email: "stephfoo.surf@gmail.com", password:"123456", username:"Stephfoo", location: "Miami", phone_number: "+15142681755")
user2 = User.create!(email: "allwavesproject@gmail.com", password:"123456", username:"user2", location: "Florida")


# <<---- Preference seeds ---->>
preset1 = Preference.new(name: "Default - Rookie", pref_unit: "FT", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "LOW", pref_tide_range: 1 )
preset1.user = stephfoo
if preset1.save
  puts "#{preset1.name} preference was saved"
else
  puts"#{preset1.name} preference was not saved"
end

preset2 = Preference.new(name: "Default - Mediocre", pref_unit: "FT", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "NORMAL", pref_tide_range: 2 )
preset2.user = stephfoo
if preset2.save
  puts "#{preset2.name} preference was saved"
else
  puts"#{preset2.name} preference was not saved"
end

preset3 = Preference.new(name: "Default - Advanced", pref_unit: "FT", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "HIGH", pref_tide_range: 3 )
preset3.user = stephfoo
if preset3.save
  puts "#{preset3.name} preference was saved"
else
  puts"#{preset3.name} preference was not saved"
end

stephfoo_spot = UserSpot.new(user: stephfoo, spot: Spot.last)

if stephfoo_spot.save!
  send_sms_notification(stephfoo, stephfoo_spot)
  puts "Sms sent to #{stephfoo.phone_number}" 
end

user_spot2 =  UserSpot.new(user: user2, spot: Spot.first)

if user_spot2.save
  UserNotifierMailer.update_conditions(user2,user_spot2).deliver
end
