class SessionController < ApplicationController

  # Skip the authenticity token to avoid problems with developer strategy.
  #
  skip_before_action :verify_authenticity_token, only: :create

  # GET /session
  #
  def show
    respond_to do |format|
      format.json
      format.html
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
    redirect_to home_path
  end

  # DELETE /session
  #
  def destroy
    session.delete(:user)
    redirect_to login_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].values_at(:provider, :uid)
  end

end
