# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

preset1 = Preference.new(name: "Rookie", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "Rookie", pref_wind_strength: "Rookie", pref_wind_direction: "Rookie", pref_tide_position: "Rookie", pref_tide_range: "Rookie" )
preset2 = Preference.new(name: "Experienced", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "Experienced", pref_wind_strength: "Experienced", pref_wind_direction: "Experienced", pref_tide_position: "Experienced", pref_tide_range: "Experienced" )
preset3 = Preference.new(name: "God Mode", pref_unit: "ft", pref_swell_height: "1", pref_swell_int: "1", pref_swell_direction: "God Mode", pref_wind_strength: "God Mode", pref_wind_direction: "God Mode", pref_tide_position: "God Mode", pref_tide_range: "God Mode" )