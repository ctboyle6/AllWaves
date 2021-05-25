class UserSpot < ApplicationRecord
  belongs_to :spot
  belongs_to :user, dependent: :destroy

  validates :spot_id, presence: true
  validates :user_id, presence: true
end
