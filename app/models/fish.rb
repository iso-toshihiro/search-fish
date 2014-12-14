class Fish < ActiveRecord::Base
  has_many :fish_spots
  has_many :spots, through: :fish_spots

  class << self
    def exist?(name)
      find_by_name(name).present?
    end
  end
end
