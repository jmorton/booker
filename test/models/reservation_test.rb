require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  test "one reservation by a guest for a unit will work" do
    reservation = Reservation.create({
      unit: units(:SF001),
      guest: guests(:YOU),
      during: 2.weeks.from_now...3.weeks.from_now
    })
    assert reservation.valid?
  end

  test "two reservations by two guests for two different units, even with the same interval, will work" do
    during = 2.weeks.from_now...3.weeks.from_now
    r1 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      during: during
    })
    r2 = Reservation.create({
      unit: units(:SF002),
      guest: guests(:HER),
      during: during
    })
    assert r1.valid?
    assert r2.valid?
  end


  test "two reservations for the same unit for two conflicting intervals, even by the same user, will not work" do
    r1 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      during: 2.days.from_now...8.days.from_now
    })
    r2 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      during: 3.days.from_now...9.days.from_now
    })
    # This test fails too, I suspect it has to do with how constraints are checked
    # inside of a transaction.
    assert r1.valid?
    assert r2.invalid?
  end

  test "two reservations for the same unit for the same interval, by different users, will not work" do
    during = 2.weeks.from_now...3.weeks.from_now
    r1 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      during: during
    })
    r2 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HER),
      during: during
    })
    # This test fails, I suspect it has to do with how constraints are checked
    # inside of a transaction.
    assert r1.valid?
    assert r2.invalid?
  end

  test "two reservations for the same unit for two non-conflicting intervals, will work" do
    r1 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HIM),
      during: 1.weeks.from_now...2.weeks.from_now
    })
    r2 = Reservation.create({
      unit: units(:SF001),
      guest: guests(:HER),
      during: 2.weeks.from_now...3.weeks.from_now
    })
    assert r1.valid?
    assert r2.valid?
  end

end
