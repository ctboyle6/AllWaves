class RemoveUtcFromConditions < ActiveRecord::Migration[6.0]
  def change
    remove_column :conditions, :utc_offset, :integer
  end
end
