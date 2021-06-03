require_relative 'spot_scrape'
require_relative '../app/mailers/sms_sender'
require 'twilio-ruby'

# <<---- Spot seeds ---->>
spot_names = %w[ pipeline] #jaws trestles
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
user1 = User.create!(email: "a@a.a", password:"123456", username:"user1", location: "Miami", phone_number: "+15142681755")
user2 = User.create!(email: "allwavesproject@gmail.com", password:"123456", username:"user2", location: "Florida")


# <<---- Preference seeds ---->>


user1_spot = UserSpot.new(user: user1, spot: Spot.last)

if user1_spot.save!
  send_sms_notification(user1, user1_spot)
  puts "Sms sent to #{user1.phone_number}"
end

user_spot2 =  UserSpot.new(user: user2, spot: Spot.first)

if user_spot2.save
  UserNotifierMailer.update_conditions(user2,user_spot2).deliver
end
