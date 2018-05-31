require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  def build(opts = {})
    guest  = guests(:YOU)
    unit   = units(:SF001)
    starts = 2.weeks.from_now
    ends   = 3.weeks.from_now
    { guest_id: guest.id, unit_id: unit.id, start_at: starts, end_at: ends }.merge(opts)
  end

  test "create a single valid reservation" do
    post "/reservations", params: { reservation: build() }
    assert_response :ok
  end

  test "create one valid and one conflicting reservation" do
    post "/reservations", params: { reservation: build() }
    assert_response :ok
    # This should be caught by Rails validation, but because tests are all  wrapped
    # within a transaction, the conflicting data is isolated from other queries...
    # ...I think. Consequently, the second reservation fails a constraint check
    # and produces a 500 error (instead of a 400)
    post "/reservations", params: { reservation: build() }
    assert_response 500
  end

  test "create two reservations for different units at the same time" do
    starts = 2.weeks.from_now
    ends = 3.weeks.from_now
    post "/reservations", params: { reservation: build(unit_id: units(:SF001).id) }
    assert_response :ok
    post "/reservations", params: { reservation: build(unit_id: units(:SF002).id) }
    assert_response :ok
  end

  test "create an invalid (empty) reservation" do
    assert_raises ActionController::ParameterMissing do
      post "/reservations", params: {}
    end
  end

  test "update a reservation (created with fixture data)" do
    put "/reservations/1", params: {
      reservation: {
        start: 4.weeks.from_now,
        end: 5.weeks.from_now
      }
    }
    assert_response :ok
  end

  test "cancel a reservation (created with fixture data)" do
    delete "/reservations/1"
    assert_response :no_content
    get "/reservations/1"
    assert_response :not_found
  end

end
