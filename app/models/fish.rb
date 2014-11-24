class Fish < ActiveRecord::Base
  has_many :fish_spots
  has_many :spots, :through :fish_spots
end
