class AddFavouriteToPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :favourite, :boolean, default: false
  end
end
