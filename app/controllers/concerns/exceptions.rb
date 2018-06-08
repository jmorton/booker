# frozen_string_literal: true

# Helper methods for handling exceptions. This module exists in order to keep
# base application controller DRY.
#
module Exceptions
  extend ActiveSupport::Concern

  included do
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ::ActiveRecord::StatementInvalid, with: :statement_invalid
  end

  protected

  def record_not_found(exception)
    render json: { error: exception.message }, status: 404
    nil
  end

  def statement_invalid(exception)
    render json: { error: exception.message }, status: 500
    nil
  end
end
