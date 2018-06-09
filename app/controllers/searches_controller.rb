# frozen_string_literal: true

# Resource to help people find nearby available units.
#
class SearchesController < ApplicationController
  # GET /search
  #
  def show
    @search = Search.new
    respond_to do |format|
      format.html
    end
  end

  # GET /search/new?near=:place&start_at=:time&end_at=:time
  #
  def new
    @search = Search.new(search_params)
    @units = @search.results.all if search_params.present? && @search.valid?
    respond_to do |format|
      format.html
      format.json { render json: @units, status: 200 }
    end
  end

  helper_method :search_params

  protected

  def search_params
    params.fetch(:search, {}).permit(:near, :start_at, :end_at)
  end
end
