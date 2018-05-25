# BOOKER

This app demonstrates a very simple reservation REST API implemented with Rails.

## Database

This app uses PostgreSQL features to enforce data integrity; you will need to
have PostgreSQL 9+ with PostGIS extensions available. The migrations handle
configuring the extensions for the schema.

To setup a development environment, make sure PostgreSQL is up, and then run:

```
rake db:migrate
rake db:create
rake db:seed
```

Tests are run like this:

```
rake tests
```

*Please note: there are  subtle issues that I'm still working on that causes tests
to fail. See "There Be Dragons" for more info.*

### REST API Sketch

This is a tentative design (not yet implemented) for the REST API.


## Get a List of Available near a location during a time interval

```
  GET /units?where=San Francisco&when=2018-05-25P7D
```

## Create a Reservation

```
  POST /reservation
  unit_id: SF01
  guest_id: SG1314
  when: 2018-05-25/2018-05-27
```

This will create a reservation, if and only if the unit is not already reserved
for an overlapping period of time.

## View a Reservation's Details

```
  GET /reservation/:reservation_id
```

### Modify a Reservation

```
  PUT /reservation/:reservation_id
  when: 2018-05-26/2018-05-29
```

### Cancel a Reservation

```
  DELETE /reservation/:reservation_id
```

## Data Model

This API handles the problem of making sure a single guest can exclusively reserve
a unit. At a high volume, Rails validations models are unable to avoid subtle race
conditions that would lead to simultaneous booking. However, PostgreSQL *is* good
at preventing this condition.

## REST API Sketch

### Guest

Someone that wants to occupy a unit for a specific period of time.

### Unit

A place that can be occupied for various intervals of time by different guests.

### Reservation

A time-interval exclusive relationship between guests and units. The guest, unit,
and duration are required. PostgreSQL prevents conflicts with `EXCLUDE` constraints.


## There Be Dragons

### Tests, Transactions, and Constraints

The following code works as expected: the first reservation is created successfully
and the second reservation fails to create a record (because the constraint is violated).

However, the unit tests related to this fail; probably because of a subtle nuance
about how constraints work within a transaction. (Setting constraints to "immediate"
does not seem to help.)

```
her = Guest.create(name: "HER")
him = Guest.create(name: "HIM")

sf1 = Unit.create(name: "SF001")
sf2 = Unit.create(name: "SF002")

# Two overlapping time ranges.
t1 = 2.days.from_now...5.days.from_now
t2 = 4.days.from_now...7.days.from_now

Reservation.create({unit: sf1, guest: her, during: t1}) # success
Reservation.create({unit: sf1, guest: her, during: t2}) # fail
```

### Time Zones, Check-In, Check-Out

Different units are possibly located in different timezones; check-in and check-out
times may vary and time to service a unit are required. In order to keep things simple,
we use a standard representation for times (ISO8601). Rails handles the conversion
of these string representations to and from PostgreSQL `tstzrange` values using
the ActiveRecord Attributes API.

### Unit and Guest Management

This app seems to imply that it also manages `Guest` and `Unit` information. If this
were implemented as a micro-service, we probably wouldn't handle this data in the DB.
Consequently, the foreign key constraints we have to ensure each reservation has
a valid guest and unit wouldn't exist. Instead, this would be handled with
`before_save` logic run in the `Reservation` model.

## Permissions

This app does not enforce any permission about who can create, modify, or delete reservations.

If this API were exposed to 3rd parties, it would be best to follow REST API authentication
and authorization patterns.

## Auditing

In order to keep track of change history, it is probably best to use a separate table
to track discrete events. This keeps the complexity of the reservations table to a minimum
while satisfying potential business needs to analyze patterns in change history or
provide customers with transparency if there is confusion about the current state
of reservations.
