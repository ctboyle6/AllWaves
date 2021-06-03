require_relative '../../db/spot_scrape'
require_relative '../../app/mailers/sms_sender'
require 'twilio-ruby'

namespace :update_conditions do
  desc "Update conditions of a specific spot"
  task refresh_conditions_spot_id_1: :environment do
    # puts "is this thing on?"
    @spot = Spot.find(1)
    @condition = Condition.where(spot: @spot)
    puts 'Cleaning out old conditions..'

    @condition.destroy_all

    puts 'Refreshing conditions..'
    puts "updating #{@spot.name}'s conditions"
    create_condition(@spot, @spot.surfline_spot)
    
    UserNotifierMailer.update_conditions(User.first,@spot).deliver
    
    puts 'Conditions refreshed'
    end
end
