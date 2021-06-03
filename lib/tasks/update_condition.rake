require_relative '../../db/spot_scrape'
require_relative '../../app/mailers/sms_sender'
require 'twilio-ruby'

namespace :update_conditions do
  desc "Update conditions of a specific spot"
  task refresh_conditions_last_spot: :environment do

    @spot = User.first.spots.last
    puts 'Cleaning out old conditions..'

    puts 'Refreshing conditions..'
    puts "updating #{@spot.name}'s conditions"
    create_condition(@spot, @spot.surfline_spot)
    
    UserNotifierMailer.update_conditions(User.first,@spot).deliver
    
    puts 'Conditions refreshed'
    end
end
