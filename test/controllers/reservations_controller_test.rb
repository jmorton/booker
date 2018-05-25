require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "create a single valid reservation" do
    time_range = "2018-05-01/2018-05-05"
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, during: time_range } }
    assert_response :created
  end

  test "create one valid and one conflicting reservation" do
    time_range_1 = "2018-05-01/2018-05-05"
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, during: time_range_1 } }
    assert_response :created
    time_range_2 = "2018-05-02/2018-05-06"
    post "/reservations", params: { reservation: { guest_id: 1, unit_id: 1, during: time_range_2 } }
    assert_response :conflict
  end

  test "create an invalid (empty) reservation" do
    post "/reservations", params: {}
    assert_response :conflict
  end

end
