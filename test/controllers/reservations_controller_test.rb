require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "create a single valid reservation" do
    reservation = build(:reservation)
    post "/reservations", params: reservation.as_json, as: :json
    assert_response :ok
  end

  test "create one valid and one conflicting reservation" do
    unit = create(:unit)
    r1 = build(:reservation, unit: unit)
    r2 = build(:reservation, unit: unit)
    post "/reservations", params: r1.as_json, as: :json
    assert_response :ok
    post "/reservations", params: r2.as_json, as: :json
    result = JSON.parse(@response.body)
    assert_response 400
  end

  test "create two reservations for different units at the same time" do
    r1 = build(:reservation)
    r2 = build(:reservation)
    post "/reservations", params: r1.as_json, as: :json
    assert_response :ok
    post "/reservations", params: r2.as_json, as: :json
    assert_response :ok
  end

  test "create an invalid (empty) reservation" do
    assert_raises ActionController::ParameterMissing do
      post "/reservations", params: {}, as: :json
    end
  end

  test "update a reservation (created with fixture data)" do
    r = create(:reservation)
    put "/reservations/#{r.id}", params: {
      reservation: {
        start_at: 4.weeks.from_now,
        end_at:   5.weeks.from_now
      }
    }, as: :json
    assert_response :ok
  end

  test "cancel a reservation (created with fixture data)" do
    r = create(:reservation)
    delete "/reservations/#{r.id}", as: :json
    assert_response :no_content
    get "/reservations/#{r.id}", as: :json
    assert_response :not_found
  end


end
