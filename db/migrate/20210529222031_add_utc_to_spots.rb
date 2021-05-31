class AddUtcToSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :utc_offset, :integer
  end
  Spot.reset_column_information
end
