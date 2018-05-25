class ReservationsController < ApplicationController

  def create
    @reservation = Reservation.new(reservation_params)
    render json: @reservation, status: 201
  end

  private

  def reservation_params
    params.require(:reservation).permit(:guest_id, :unit_id, :during)
  end

end
