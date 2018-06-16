# Here Be Dragons

## Reservation Constraints

Currently, there are very few constraints related to reservations.

It would be prudent for the system to...

* Limit cancellation to a predefined time before the reservation begins.
* Limit modification, especially after a reservation has finished.
* Enforce minimum and maximum duration of a reservation. (e.g. 30-90 days)

## Auditing

This app preserves historical information in the `audits` table. I need to make sure that this can be a) extracted or b) queried by the appropriate users.


