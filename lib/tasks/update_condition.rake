require_relative '../../db/spot_scrape'
require_relative '../../app/mailers/sms_sender'
require 'twilio-ruby'

namespace :notifications do
  desc "Update conditions of a specific spot"
  task update_last_spot_conditions: :environment do

    @spot = User.first.spots.last
    puts 'Cleaning out old conditions..'

    puts 'Refreshing conditions..'
    puts "updating #{@spot.name}'s conditions"
    create_condition(@spot, @spot.surfline_spot)
    @condition = @spot.conditions.last

    # New updated conditions
    @condition.update(
      # spot_id: new_spot.id,
      # timestamp: @timestamp,
      # wind_strength: @wind_strength,
      # wind_direction: @wind_direction,
      wind_optimal_score: 4,
      # waves_surf_min: @waves_surf_min,
      # waves_surf_max: @waves_surf_max,
      # waves_optimal_score: @waves_surf_optimal_score,
      # tide_type: @tide_type,
      # waves_swell_height: @waves_swell_height,
      # waves_swell_period: @waves_swell_period,
      # waves_swell_direction: @waves_swell_direction,
      # waves_swell_direction_min: @waves_swell_direction_min,
      # waves_swell_optimal_score: @waves_swell_optimal_score,
    )



    UserNotifierMailer.update_conditions(User.first, @spot, @condition).deliver
    
    puts 'Conditions refreshed'
    end
end
