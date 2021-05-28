class AddTimeAtToConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :conditions, :time_at, :datetime
    Condition.find_each do |condition|
      condition.update(time_at: Time.at(condition.timestamp).to_datetime)
    end
    # change_column :conditions, :time_at, :datetime, null: false
  end
end
