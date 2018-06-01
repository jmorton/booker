require 'test_helper'

class UnitsControllerTest < ActionDispatch::IntegrationTest

  test("available tomorrow for a week") do
    2.times { create(:unit) }
    t1, t2 = 1.day.from_now, 1.week.from_now
    get "/units", params: { near: "Sioux Falls, SD", start_at: t1, end_at: t2 }
    result = JSON.parse(@response.body)
    assert_response :ok
    assert_equal 2, result['units'].length
  end

  test("available next week for a month") do
    2.times { create(:unit) }
    2.times { create(:reservation) }
    t1, t2 = 1.week.from_now, (1.week + 1.month).from_now
    get "/units", params: { near: "Sioux Falls, SD", start_at: t1, end_at: t2 }
    result = JSON.parse(@response.body)
    assert_response :ok
    assert_equal 2, result['units'].length
  end

  test("available next year for a month") do
    2.times { create(:unit) }
    2.times { create(:reservation) }
    t1, t2 = 12.months.from_now, 13.months.from_now
    get "/units", params: { near: "Sioux Falls, SD", start_at: t1, end_at: t2 }
    result = JSON.parse(@response.body)
    assert_response :ok
    assert_equal 4, result['units'].length
  end

end
