require_relative '../../db/spot_scrape'

namespace :update_conditions do
  desc "Update conditions of a specific spot"
  task refresh_conditions: :environment do
    # puts "is this thing on?"
    @spot = Spot.search_by_spot_name("Pipeline")

    puts 'Cleaning out old conditions..'
    condition = Condition.
    @spot
    Condition.destroy_all

    puts 'Refreshing conditions..'
    @spots.each do |spot|
      puts "updating #{spot.name}'s conditions"
      create_condition(spot, spot.surfline_spot)
    end

    puts 'Conditions refreshed'
  end
end
