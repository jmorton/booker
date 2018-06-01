class UnitsController < ApplicationController


  # GET /units?near=:place&start_at=:time&end_at=:time
  #
  def index
    place, t1, t2 = search_params[:near], search_params[:start_at], search_params[:end_at]
    @units = Unit.near(place).available(t1,t2).all
    render json: {units: @units}, status: 200
  end


  private

  def search_params
    params.permit(:near, :start_at, :end_at)
  end

end
