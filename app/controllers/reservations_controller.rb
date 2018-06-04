# Reservation resource handlers.
#
class ReservationsController < ApplicationController

  # GET /reservations/:id
  #
  def show
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @reservation, status: 200 }
    end
  end

  # GET /reservations/new
  #
  def new
    @reservation = Reservation.new
    respond_to do |format|
      format.html
    end
  end

  # POST /reservations
  #
  def create
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|
      if @reservation.save
        format.html
        format.json { render json: @reservation, status: 200 }
      else
        format.html { render :new }
        format.json { render json: {reservation: @reservation, errors: @reservation.errors}, status: 400 }
      end
    end
  end

  # PUT /reservations/:id
  #
  def update
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html
        format.json { render json: @reservation, status: 200 }
      else
        format.html
        format.json { render json: {reservation: @reservation, errors: @reservation.errors}, status: 400 }
      end
    end
  end

  # DELETE /reservations/:id
  #
  def destroy
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      if @reservation.destroy
        format.json { render json: nil, status: 204 }
      else
        format.json { render json: nil, status: 400 }
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:id, :guest_id, :unit_id, :start_at, :end_at)
  end

end
