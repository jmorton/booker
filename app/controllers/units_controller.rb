class UnitsController < ApplicationController

  # GET /units?near=:place&start_at=:time&end_at=:time
  #
  def index
    @search = Search.new(search_params)
    @units = @search.results.all

    respond_to do |format|
      format.html
      format.json { render json: @units, status: 200 }
    end
  end

  # GET /units/:id
  #
  def show
    @unit = Unit.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @unit, status: 200 }
    end
  end

  private

  def search_params
    params.fetch(:search, {}).permit(:near, :start_at, :end_at)
  end

end
