require_relative '../../db/spot_scrape'

namespace :db do
  desc "Refresh conditions for each spot in database"
  task refresh_conditions: :environment do
    # puts "is this thing on?"
    @spots = Spot.all

    puts 'Cleaning out old conditions..'
    Condition.destroy_all

    puts 'Refreshing conditions..'
    @spots.each do |spot|
      puts "updating #{spot.name}'s conditions"
      create_condition(spot, spot.surfline_spot)
    end

    puts 'Conditions refreshed'
  end
end
