require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "create a single valid reservation" do
    starts = "2018-05-01"
    ends = "2018-05-05"
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, start_at: starts, end_at: ends } }
    assert_response :ok
  end

  test "create one valid and one conflicting reservation" do
    starts = "2018-05-01"
    ends = "2018-05-05"
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, start_at: starts, end_at: ends } }
    assert_response :ok
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, start_at: starts, end_at: ends } }
    assert_response :bad_request
  end

  test "create two reservations for different units at the same time" do
    starts = "2018-05-01"
    ends = "2018-05-05"
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, start_at: starts, end_at: ends } }
    assert_response :ok
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 2, start_at: starts, end_at: ends } }
    assert_response :ok
  end

  test "create an invalid (empty) reservation" do
    assert_raises ActionController::ParameterMissing do
      post "/reservations", params: {}
    end
  end

end
