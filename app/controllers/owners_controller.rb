# frozen_string_literal: true

# The parent class of all Owner related controllers.
#
class OwnersController < ApplicationController
  include Identification

  layout 'owner'

  # GET /owner
  #
  def show
    @owner = owner
    respond_to do |format|
      format.html
    end
  end

  # GET /owner/app
  #
  def app
    render layout: 'vue'
  end

  protected

  helper_method :owner

  def owner
    return nil if identity.blank?
    @owner ||= Owner.where(identity: identity).first_or_create
  end
end
