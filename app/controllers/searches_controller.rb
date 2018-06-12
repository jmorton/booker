# frozen_string_literal: true

# Resource to help people find nearby available units.
#
class SearchesController < ApplicationController
  # GET /search
  #
  def show
    @search = search_model
    respond_to do |format|
      if search_params.present? && @search.invalid?
        format.js   { render status: 400 }
        format.html { render status: 400 }
        format.json { render json: @search.errors, status: 400 }
      else
        format.js   { render status: 200 }
        format.html { render status: 200 }
        format.json { render json: @search.results, status: 200 }
      end
    end
  end

  protected

  def search_params
    params.permit(:near, :start_at, :end_at)
  end

  def search_model
    Search.new(search_params)
  end
end
