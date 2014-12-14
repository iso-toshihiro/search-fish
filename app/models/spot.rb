class Spot < ActiveRecord::Base
  has_many :fish_spots
  has_many :fish, through: :fish_spots

  class << self
    def exist?(spot)
      find_by_name(spot).present?
    end
  end
end
