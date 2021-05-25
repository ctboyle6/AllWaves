class CreateConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :conditions do |t|
      t.jsonb :conditions_json
      t.references :spots, null: false, foreign_key: true

      t.timestamps
    end
  end
end
