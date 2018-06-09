# frozen_string_literal: true

# The parent class of all Owner related controllers.
#
class GuestsController < ApplicationController
  include Identification

  # GET /guest
  #
  def show
    @guest = guest
    respond_to do |format|
      format.html
    end
  end

  protected

  helper_method :guest

  def guest
    return nil if identity.blank?
    @guest ||= Guest.where(identity: identity).first_or_create
  end
end
