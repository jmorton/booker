# frozen_string_literal: true

module Owners
  # Units from an Owner's point of view.
  #
  class UnitsController < OwnersController
    # GET /units?near=:place&start_at=:time&end_at=:time
    #
    def index
      @units = owner_units.all
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

    # GET /units/new
    #
    def new
      @unit = owner_units.new
      respond_to do |format|
        format.html
        format.json { render json: @unit, status: 200 }
      end
    end

    # POST /units
    #
    def create
      @unit = owner_units.new(unit_params)
      respond_to do |format|
        if @unit.save
          format.html { redirect_to [:owners, @unit] }
          format.json { render json: @unit, status: 200 }
        else
          format.html { render :new, status: 400 }
          format.json { render json: @unit, status: 400 }
        end
      end
    end

    # GET /units/:id
    #
    def edit
      @unit = owner_units.find(params[:id])
      respond_to do |format|
        format.html
      end
    end

    # PUT /units/:id
    #
    def update
      @unit = owner_units.find(params[:id])
      @unit.update(unit_params)
      respond_to do |format|
        if @unit.valid?
          format.html { render :show, status: 200 }
          format.json { render json: @unit, status: 200 }
        else
          format.html { render :edit, status: 400 }
          format.json { render json: { unit: @unit, errors: @unit.errors }, status: 400 }
        end
      end
    end

    private

    def search_params
      params.fetch(:search, {}).permit(:near, :start_at, :end_at)
    end

    def owner_units
      owner&.units
    end

    def unit_params
      params.fetch(:unit, {}).permit(:id, :address)
    end
  end
end
