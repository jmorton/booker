# frozen_string_literal: true

module Owners
  # Provide support images attached to an owner's unit.
  #
  class ImagesController < OwnersController
    # DELETE /owner/units/:unit_id/images
    #
    def index
      @unit = unit
      @images = unit.images
      respond_to do |format|
        format.html
      end
    end

    # GET /owner/units/:unit_id/images/:id
    #
    def show
      @unit = unit
      @image = image
    end

    # DELETE /owner/units/:unit_id/images/:id
    #
    def destroy
      respond_to do |format|
        if image.purge
          flash[:notice] = 'Image deleted.'
          format.js   { render status: 200 }
          format.html { redirect_back fallback_location: edit_owner_unit_path(unit) }
        else
          flash[:error] = 'Could not remove the image.'
          format.js   { render status: 500 }
          format.html { redirect_back fallback_location: edit_owner_unit_path(unit) }
        end
      end
    end

    private

    helper_method :unit

    def unit
      owner.units.find(params[:unit_id])
    end

    def image
      unit.images.find(params[:id])
    end
  end
end
