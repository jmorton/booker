class ReservationsController < ApplicationController

  # GET /reservations/:id
  #
  def show
    @reservation = Reservation.find(params[:id])
    render json: {reservation: @reservation}, status: 200
  end


  # POST /reservations
  #
  def create
    @reservation = Reservation.create(reservation_params)
    if @reservation.errors.empty?
      render json: {reservation: @reservation}, status: 200
    else
      render json: {reservation: @reservation, errors: @reservation.errors}, status: 400
    end
  end

  # PUT /reservations
  #
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      render json: {reservation: @reservation}, status: 200
    else
      render json: {reservation: @reservation, errors: @reservation.errors}, status: 400
    end
  end


  # DELETE /reservations
  #
  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      render json: @reservation, status: 204
    else
      render json: @reservation, status: 400
    end
  end


  private


  def reservation_params
    params.require(:reservation).permit(:id, :guest_id, :unit_id, :start_at, :end_at)
  end


end
