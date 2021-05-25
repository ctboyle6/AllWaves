class Condition < ApplicationRecord
  belongs_to :spot

  validates :conditions_json, presence: true
end
