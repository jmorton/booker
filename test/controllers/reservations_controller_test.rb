require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "create a single valid reservation" do
    reservation = build(:reservation)
    post "/reservations", params: { reservation: reservation.as_json }
    assert_response :ok
  end

  test "create one valid and one conflicting reservation" do
    unit = create(:unit)
    r1 = build(:reservation, unit: unit)
    r2 = build(:reservation, unit: unit)
    post "/reservations", params: { reservation: r1.as_json }
    assert_response :ok
    post "/reservations", params: { reservation: r2.as_json }
    assert_response 500
  end

  test "create two reservations for different units at the same time" do
    r1 = build(:reservation)
    r2 = build(:reservation)
    post "/reservations", params: { reservation: r1.as_json }
    assert_response :ok
    post "/reservations", params: { reservation: r2.as_json }
    assert_response :ok
  end

  test "create an invalid (empty) reservation" do
    assert_raises ActionController::ParameterMissing do
      post "/reservations", params: {}
    end
  end

  test "update a reservation (created with fixture data)" do
    r = create(:reservation)
    put "/reservations/#{r.id}", params: {
      reservation: {
        start_at: 4.weeks.from_now,
        end_at:   5.weeks.from_now
      }
    }
    assert_response :ok
  end

  test "cancel a reservation (created with fixture data)" do
    r = create(:reservation)
    delete "/reservations/#{r.id}"
    assert_response :no_content
    get "/reservations/#{r.id}"
    assert_response :not_found
  end


end
