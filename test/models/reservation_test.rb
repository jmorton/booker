require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  test "create reservation" do
    r = create(:reservation)
    assert r.valid?, "could not create a Reservation (using the factory)"
  end

  test "two reservations for the same unit for two non-conflicting intervals, will work" do
    unit = create(:unit)
    her  = create(:guest, name: "Her")
    him  = create(:guest, name: "Him")
    r1 = Reservation.create({guest: her, unit: unit, start_at: 2.weeks.from_now, end_at: 3.weeks.from_now})
    r2 = Reservation.create({guest: him, unit: unit, start_at: 3.weeks.from_now, end_at: 4.weeks.from_now})
    assert r1.valid?
    assert r2.valid?
  end

  test "two reservations for the same unit for overlapping intervals, will not work" do
    unit = create(:unit)
    her  = create(:guest, name: "Her")
    him  = create(:guest, name: "Him")
    assert_raises(ActiveRecord::StatementInvalid) do
      r1 = Reservation.create({guest: her, unit: unit, start_at: 3.days.from_now, end_at: 5.days.from_now})
      r2 = Reservation.create({guest: him, unit: unit, start_at: 4.days.from_now, end_at: 6.days.from_now})
      assert r1.valid?
    end
  end

end
