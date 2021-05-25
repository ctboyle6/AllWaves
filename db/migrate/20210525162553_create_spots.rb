class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :surfline_spot
      t.string :surfline_subregion

      t.timestamps
    end
  end
end
