class DivingSpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @fish = @spot.fish
  end
end
