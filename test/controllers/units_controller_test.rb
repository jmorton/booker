require 'test_helper'

class UnitsControllerTest < ActionDispatch::IntegrationTest

  # This test exists because the test cases rely heavily on fixture data. The
  # alternative, creating test case data on the fly would work, but it could
  # make the tests less succint.
  test "fixture data expectations haven't changed" do
    assert_equal 3, Guest.count, "did guest fixtures changes?"
    assert_equal 3, Unit.count, "did unit fixtures change?"
    assert_equal 3, Reservation.count, "did reservation fixtures changes?"
  end

  test("available tomorrow for a week") do
    t1, t2 = 1.day.from_now, 1.week.from_now
    get "/units", params: { near: "Sioux Falls, SD", start_at: t1, end_at: t2 }
    result = JSON.parse(@response.body)
    assert_response :ok
    assert_equal 2, result['units'].length
  end

  test("available next week for a month") do
    t1, t2 = 1.week.from_now, (1.week + 1.month).from_now
    get "/units", params: { near: "Sioux Falls, SD", start_at: t1, end_at: t2 }
    result = JSON.parse(@response.body)
    assert_response :ok
    assert_equal 1, result['units'].length
  end

  test("available next year for a month") do
    t1, t2 = 12.months.from_now, 13.months.from_now
    get "/units", params: { near: "Sioux Falls, SD", start_at: t1, end_at: t2 }
    result = JSON.parse(@response.body)
    assert_response :ok
    assert_equal 3, result['units'].length
  end

end
