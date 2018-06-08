# frozen_string_literal: true

# Helper methods for authentication. This module exists in order to keep
# base application controller DRY.
#
module Identification
  extend ActiveSupport::Concern

  included do
    before_action :require_identity
    helper_method :identity
  end

  protected

  def identity
    return nil if session[:user].blank?
    @identity ||= Identity.find(session[:user])
  end

  def require_identity
    return if identity.present?
    session[:back_path] = request.fullpath
    redirect_to login_path
  end
end
