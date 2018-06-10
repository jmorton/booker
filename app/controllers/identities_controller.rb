# frozen_string_literal: true

# Identity resource handlers.
#
class IdentitiesController < ApplicationController
  include Identification

  # GET /identity
  #
  def show
    @identity = identity
    respond_to do |format|
      format.html
      format.json { render json: @identity }
    end
  end

  # GET /identity/app
  #
  def app
    render layout: 'mine'
  end

  # DELETE /identity
  #
  def destroy
    @identity = identity
    respond_to do |format|
      if @identity.destroy
        format.html { redirect_to login_path }
        format.json { render status: 204 }
      end
    end
  end
end
