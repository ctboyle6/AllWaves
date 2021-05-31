class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_spots, dependent: :destroy
  has_many :spots, through: :user_spots
  has_many :preferences, dependent: :destroy
  has_one_attached :avatar

  def grouped_spots
    # spots.order(favourite: :desc)
    spots
  end
end
