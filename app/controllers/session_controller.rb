# frozen_string_literal: true

# Session resource handlers.
#
class SessionController < ApplicationController
  layout 'application'

  # Skip the authenticity token to avoid problems with developer strategy.
  #
  skip_before_action :verify_authenticity_token, only: :create

  # GET /session
  #
  def show
    @session = session[:user]
    respond_to do |format|
      format.html
      format.json { render json: @session }
    end
  end

  # GET /login
  #
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /auth/:provider/callback
  #
  def create
    session[:user] = Identity.authenticate(request.env['omniauth.auth']).id
    respond_to do |format|
      format.html { redirect_to session.delete(:back_path) || root_path }
      format.json { render json: @session, status: 201 }
    end
  end

  # DELETE /session
  #
  def destroy
    session.delete(:user)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: nil, status: 200 }
    end
  end
end
