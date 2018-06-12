module Owners
  # Provide support images attached to an owner's unit.
  #
  class ImagesController < OwnersController

    # DELETE /owner/units/:unit_id/images
    #
    def index
      @unit, @images = unit, unit.images
      respond_to do |format|
        format.html
      end
    end

    def show
      @unit, @image = unit, image
    end

    # DELETE /owner/units/:unit_id/images/:id
    #
    def destroy
      respond_to do |format|
        if image.destroy
          format.js   { render status: 200 }
          format.html { redirect_back fallback_location: edit_owner_unit_path(unit) }
        else
          format.js   { render status: 400 }
          format.html { redirect_back fallback_location: edit_owner_unit_path(unit) }
        end
      end
    end

    private

    helper_method :unit

    def unit
      owner&.units.find(params[:unit_id])
    end

    def image
      unit.images.find(params[:id])
    end
  end
end
