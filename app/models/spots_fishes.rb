class SpotsFishes < ActiveRecord::Base
  belongs_to :spot
  belongs_to :fish
end
