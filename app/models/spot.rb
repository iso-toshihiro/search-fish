class Spot < ActiveRecord::Base
  has_many :fish_spots
  has_many :fish, :through :fish_spot
end
