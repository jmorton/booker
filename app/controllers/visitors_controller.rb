# frozen_string_literal: true

# Visitors are unauthenticated users; this provides a place for handling those
# requests.
#
class VisitorsController < ApplicationController
  # GET /visitors
  #
  def show
    redirect_to search_path
  end
end
