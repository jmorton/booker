# BOOKER

This app demonstrates a very simple reservation REST API implemented with Rails.

## Configuration

This app uses `.env` files to configure development and test environments. Create
a copy like this:

```
cp .env .env.development
```

| Key             | Value                                                |
| MY_CONTACT_INFO | Tells the free geocoding service who you are.        |

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

This will create three guests and three units.


## Tests

Tests are run like this:

```
rake tests
```


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


### Cancel a Reservation

```
  DELETE /reservation/:id
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

### Time Zones, Check-In, Check-Out

Different units are possibly located in different timezones; check-in and check-out
times may vary and time to service a unit are required. In order to keep things simple,
we use a standard representation for times (ISO8601). Rails handles the conversion
of these string representations to and from PostgreSQL timestamp with timezone values.

### Application Level Constraints

* Consider limiting cancellation.
* Consider adopting a unit's timezone, check-in, and check-out time when creating a reservation.
* Consider enforcing unit specific minimum and maximum stay intervals.

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

## Test Data

Once logic is defined to prevent reservations from being created in the past, time
values for seed and test data will need to be checked.
