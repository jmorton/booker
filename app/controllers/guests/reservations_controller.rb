# frozen_string_literal: true

module Guests
  # Reservations from a Guest's point of view.
  #
  class ReservationsController < GuestsController
    # GET /reservations
    #
    def index
      @reservations = guest_reservations
      respond_to do |format|
        format.html
        format.json { render json: @reservations }
      end
    end

    # GET /reservations/:id
    #
    def show
      @reservation = guest_reservations.find(params[:id])
      respond_to do |format|
        format.html
        format.json { render json: @reservation, status: 200 }
      end
    end

    # GET /reservations/new
    #
    def new
      @reservation = guest_reservations.new(reservation_params)
      respond_to do |format|
        format.html
      end
    end

    # GET /reservations/:id/edit
    #
    def edit
      @reservation = guest_reservations.find(params[:id])
      respond_to do |format|
        format.html
      end
    end

    # POST /reservations
    #
    def create
      @reservation = guest_reservations.new(reservation_params)
      respond_to do |format|
        if @reservation.save
          flash[:notice] = 'Reservation created.'
          format.html { redirect_to guest_reservation_path(@reservation) }
          format.json { render json: @reservation, status: 200 }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors.full_messages, status: 400 }
        end
      end
    end

    # PUT /reservations/:id
    #
    def update
      @reservation = guest_reservations.find(params[:id])
      @reservation.update(reservation_params)
      respond_to do |format|
        if @reservation.valid?
          flash[:notice] = 'Reservation updated.'
          format.html { render :show, status: 200 }
          format.json { render json: @reservation, status: 200 }
        else
          format.html { render :edit, status: 400 }
          format.json { render json: { reservation: @reservation, errors: @reservation.errors }, status: 400 }
        end
      end
    end

    # DELETE /reservations/:id
    #
    def destroy
      @reservation = guest_reservations.find(params[:id])
      respond_to do |format|
        if @reservation.destroy
          flash[:notice] = 'Reservation cancelled.'
          format.html { redirect_to guest_reservations_path }
          format.json { render status: 204 }
        else
          format.html { redirect_to :back }
          format.json { render json: nil, status: 400 }
        end
      end
    end

    private

    def guest_reservations
      guest&.reservations
    end

    def reservation_params
      params.fetch(:reservation, {}).permit(:id, :unit_id, :start_at, :end_at)
    end
  end
end
