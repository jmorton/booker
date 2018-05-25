# Reservations are used to prevent the same unit from being booked simultaneously
# by different guests. This constraint is enforced at the persistence layer to
# avoid complex business logic in the model.
#
# A reservation has a:
# * guest – a reference to a Guest entity
# * unit – a reference to a Unit entity
# * when – a timezone timestamp range value
#
#
#

class Reservation < ApplicationRecord
  belongs_to :guest, required: true
  belongs_to :unit, required: true
  validates :during, presence: true
end
