require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  test "one reservation by a guest for a unit will work" do
    reservation = Reservation.create({
      unit: units(:SF001),
      guest: guests(:YOU),
      start_at: 2.weeks.from_now,
      end_at: 3.weeks.from_now
    })
    assert reservation.valid?
  end

  test "two reservations by two guests for two different units, even with the same interval, will work" do
    r1 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      start_at: 2.weeks.from_now,
      end_at: 3.weeks.from_now
    })
    r2 = Reservation.create({
      unit: units(:SF002),
      guest: guests(:HER),
      start_at: 2.weeks.from_now,
      end_at: 3.weeks.from_now
    })
    assert r1.valid?
    assert r2.valid?
  end


  test "two reservations for the same unit for two conflicting intervals, even by the same user, will not work" do
    assert_raises(ActiveRecord::StatementInvalid) do
      r1 = Reservation.create({
        unit: units(:SF001),
        guest: guests(:HIM),
        start_at: 2.weeks.from_now,
        end_at: 3.weeks.from_now
      })
      r2 = Reservation.create({
        unit: units(:SF001),
        guest: guests(:HIM),
        start_at: 2.weeks.from_now,
        end_at: 3.weeks.from_now
      })
    end
  end

  test "two reservations for the same unit for the same interval, by different users, will not work" do
    assert_raises(ActiveRecord::StatementInvalid) do
      r1 = Reservation.create({
        unit: units(:SF001),
        guest: guests(:HIM),
        start_at: 2.weeks.from_now,
        end_at: 3.weeks.from_now
      })
      r2 = Reservation.create({
        unit: units(:SF001),
        guest: guests(:HER),
        start_at: 2.weeks.from_now,
        end_at: 3.weeks.from_now
      })
    end
  end

  test "two reservations for the same unit for two non-conflicting intervals, will work" do
    r1 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      start_at: 2.weeks.from_now,
      end_at: 3.weeks.from_now
    })
    r2 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HER),
      start_at: 4.weeks.from_now,
      end_at: 5.weeks.from_now
    })
    assert r1.valid?
    assert r2.valid?
  end

end
