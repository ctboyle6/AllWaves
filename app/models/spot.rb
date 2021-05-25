class Spot < ApplicationRecord
  has_many :conditions, dependent: :destroy
end
