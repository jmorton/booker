# frozen_string_literal: true

# Session resource handlers.
#
class SessionController < ApplicationController
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
    session[:user] = auth_hash
    respond_to do |format|
      format.html { redirect_to home_path }
      format.json { render json: @session, status: 201 }
    end
  end

  # DELETE /session
  #
  def destroy
    session.delete(:user)
    respond_to do |format|
      format.html { redirect_to login_path }
      format.json { render json: nil, status: 200 }
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].slice('provider', 'uid')
  end
end
