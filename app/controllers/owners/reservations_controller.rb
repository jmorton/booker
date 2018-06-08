# frozen_string_literal: true

module Owners
  # Reservation from an Owner's point of view.
  #
  class ReservationsController < OwnersController
    # GET /reservations
    #
    def index
      @reservations = owner.reservations.all
      respond_to do |format|
        format.html
        format.json { render json: @reservations }
      end
    end

    # GET /reservations/:id
    #
    def show
      @reservation = Reservation.find(params[:id])
      respond_to do |format|
        format.html
        format.json { render json: @reservation, status: 200 }
      end
    end
  end
end
