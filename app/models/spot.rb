class Spot < ApplicationRecord

  has_many :user_spots
  has_many :conditions, dependent: :destroy

end
