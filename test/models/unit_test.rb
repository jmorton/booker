require 'test_helper'

class UnitTest < ActiveSupport::TestCase

  test "create unit" do
    u = create(:unit)
    assert u.valid?, "could not create a Unit (using the factory)"
  end

  test "three units are reserved next week, but are available after." do

    # Create three reservations (each with their own guest and unit)
    3.times { create(:reservation) }

    # If this gets messed up, factories have changed.
    assert_equal 3, Unit.count, "did the Unit factory change?"
    assert_equal 3, Guest.count, "did the Guest factory change?"
    assert_equal 3, Reservation.count, "did the Reservation factory change?"

    # How do things look next week?
    t1, t2 = 1.week.from_now, 2.weeks.from_now
    assert_equal 3, Unit.reserved(t1, t2).count
    assert_equal 0, Unit.available(t1, t2).count

    # How about two weeks after that?
    t1, t2 = (2.week).from_now, 3.weeks.from_now
    assert_equal 0, Unit.reserved(t1, t2).count
    assert_equal 3, Unit.available(t1, t2).count

    # How about tomorrow?
    t1, t2 = 1.day.from_now, 2.days.from_now
    assert_equal 0, Unit.reserved(t1, t2).count
    assert_equal 3, Unit.available(t1, t2).count

  end

end
