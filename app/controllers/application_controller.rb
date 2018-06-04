# frozen_string_literal: true

# The parent class of all our application controllers.
#
class ApplicationController < ActionController::Base
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from ::ActiveRecord::StatementInvalid, with: :statement_invalid

  private

  def record_not_found(exception)
    render json: { error: exception.message }, status: 404
    nil
  end

  def statement_invalid(exception)
    render json: { error: exception.message }, status: 500
    nil
  end
end
