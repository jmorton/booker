# frozen_string_literal: true

# Unit resource handlers.
#
module Guests
  # Units from a Guest's point of view.
  #
  class UnitsController < GuestsController
    # GET /guest/units
    #
    def index
      @units = guest.units
      respond_to do |format|
        format.html
        format.json { render json: @units, status: 200 }
      end
    end

    # GET /guest/units/:id
    #
    def show
      @unit = Unit.find(params[:id])
      respond_to do |format|
        format.html
        format.json { render json: @unit, status: 200 }
      end
    end
  end
end
