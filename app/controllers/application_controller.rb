# frozen_string_literal: true

# The parent class of all our application controllers.
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session
  include Exceptions

  def pick
    if session[:user].present?
      redirect_to(identity_path) && return
    else
      redirect_to(visitor_path) && return
    end
  end
end
