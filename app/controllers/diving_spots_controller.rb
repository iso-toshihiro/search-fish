class DivingSpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
  end
end
