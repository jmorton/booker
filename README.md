# BOOKER

This app demonstrates a very simple reservation REST API implemented with Rails.

## Setup

### Environment Variables

This app uses `.env` files to configure development and test environments. Create
a copy like this:

```
cp .env .env.development
```

Currently, there is only a single key/value.

| Key             | Value                                                |
|-----------------|------------------------------------------------------|
| MY_CONTACT_INFO | Tells the free geocoding service who you are.        |

### Database

This app uses PostgreSQL features to enforce data integrity; you will need to
have PostgreSQL 9+ with PostGIS extensions available. The migrations handle
configuring the extensions for the schema.

To setup a development environment, make sure PostgreSQL is up, and then run:

```
rake db:setup
```

This will create the DB, load the schema, and create three guests and three units.


## Tests

Tests are run like this:

```
rake tests
```

Features are documented (and tested) like this:

```
rake cucumber
```

Traditional tests are used to build up low level capabilities. Cucumber features
are present so that business-type people can see how things are going at a high
level.

## REST API

### Get a List of Available near a location during a time interval

```
  GET /units?where=Sioux Falls, SD&start_at=2018-07-01&end_at=2018-08-01
```

This will retrieve a list of units that have no reservations during the given time.


### Create a Reservation

```
  POST /reservation
  guest_id: 1
  unit_id:  1
  start:    2018-05-25
  end:      2018-05-27
```

This will create a reservation, if and only if the unit is not already reserved
for an overlapping period of time.


### View a Reservation's Details

```
  GET /reservation/:id
```


### Modify a Reservation

```
  PUT /reservation/:id
  guest_id: 1
  unit_id:  2
  start:    2018-05-26
  end:      2018-05-29
```

This will change a reservation; history is preserved in the `audits` table.


### Cancel a Reservation

```
  DELETE /reservation/:id
```

This will remove a reservation; history is preserved in the `audits` table.


## Data Model

The system exposes data about Guests, Units, and Reservations.

### Guest

Someone that wants to occupy a unit for a specific period of time.

### Unit

A place that can be occupied for various intervals of time by different guests.

Units are geocoded whenever their address is changed in order to support location
based queries.

### Reservation

A time-interval exclusive relationship between guests and units. A valid guest, unit,
and duration are required.

### Audits

The system keeps old versions of entities to assist system operators with insight
about what people are doing and to help resolve potential disputes.


## There Be Dragons

This app started with a bit of a flurry, so it's important to keep track of some
potential issues, even if they are a bit ambiguous...

### Time Zones, Check-In, Check-Out

When reserving a Unit it will be important to figure out and enforce the actual
times of day that a unit is reserved for a Guest. This time probably won't be
user specified, and it definitely needs to take into account the timezone of the
unit.

It might be wise to ignore any time value more granular than a day, provided by a
user, relying instead on a property of each Unit to determine the start and end time.

### Reservation Constraints

* Limit cancellation to a predefined time before the reservation begins.
* Limit modification, especially after a reservation has finished.
* Enforce minimum and maximum duration of a reservation. (e.g. 30-90 days)

### Permissions

This app does not enforce any permission about who can create, modify, or delete
reservations.

Given that this is an API, we'll probably adopt a gem that supports JWT.

### Auditing

This app preserves historical information in the `audits` table. I need to make
sure that this can be a) extracted or b) queried by the appropriate users.

### Test Data

Test data is generated using Factory Bot. Fixtures can become quite unwieldy,
so producing what is needed on-the-fly seems smart.


## License

(c) Jonathan Morton 2018 – MIT License
