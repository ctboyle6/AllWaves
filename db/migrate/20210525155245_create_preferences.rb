class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|

      t.string :name
      t.string :pref_unit
      t.float :pref_swell_height
      t.float :pref_swell_int
      t.string :pref_swell_direction
      t.string :pref_wind_strength
      t.string :pref_wind_direction
      t.string :pref_tide_position
      t.string :pref_tide_range
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
