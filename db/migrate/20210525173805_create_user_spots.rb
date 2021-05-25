class CreateUserSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :user_spots do |t|
      t.references :spot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
