class AddUtcToConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :conditions, :utc_offset, :integer
  end
  Condition.reset_column_information
end
