# BOOKER

[![build](https://travis-ci.org/jmorton/booker.svg?branch=master)](https://travis-ci.org/jmorton/booker)
[![security](https://hakiri.io/github/jmorton/booker/master.svg)](https://hakiri.io/github/jmorton/booker/master)

## Intro

Booker is a Reservation system based on Rails 5. It's not used in the real-world
for anything (as far as I know) but it should help you answer a variety of questions
about how to build something similar. It's also a pretty good way for you to
figure out if I actually know how to build things.

## Setup

There are five steps to setup a local development environment. I assume you already
have Ruby, Rails, and PostgreSQL installed.

### 1. Install Dependencies

Booker uses ActiveStorage for images, you will need libvips installed. On MacOS,
this can be installed using `brew`.

```
brew install vips
```

Install the application gems.

```
bundle install
```

Install Javascript dependencies.

```
yarn install
```

### 2. Configure Environment Values

This app uses `.env` files to configure development and test environments. Create
a copy like this:

```
cp .env.example .env.development
```

### 3. Initialize PostgreSQL

If you aren't running PostgreSQL already, you can initialize an instance that will
be stored in the project (but ignored by git).

```
mkdir db/pg
initdb --pgdata db/pg
```

### 4. Start Everything

```
bundle exec foreman start
```

### 5. Initialize Booker's Schema

```
bin/rails db:setup
```


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

## OmniAuth Provider Configuration

In order to setup a development environment to work with 3rd party providers (Google,
Twitter, GitHub, etc...), you will need to perform some pretty tedious configuration.

This is an optional step, given that the OmniAuth Developer strategy serves our
purposes. But if you're ready to roll up your sleeves, here's what to do!

### Configure Your Hostname

First, pick a hostname and add it to `/etc/hosts`. I've configured my system using
a hostname with a valid top-level domain because Google OAuth2 requirements.

```
127.0.0.1	dev.booker.jonmorton.me
```

### Generate a Self-Signed Certificate

Next, generate a self-signed certificate. This command produces a certificate that

```
HOST="dev.booker.jonmorton.me" \
openssl req \
        -x509 \
        -sha256 -nodes -newkey rsa:2048 -days 365 \
        -subj "/CN=$HOST" \
        -keyout tmp/dev.key -out tmp/dev.crt
```

### Configure Environment with Provider Credentials

Now, go configure your providers.

* [Google](https://console.developers.google.com/apis/credentials)
* [Twitter](https://apps.twitter.com/)
* [GitHub](https://github.com/settings/applications/new)
* [Discord](https://discordapp.com/developers/applications/me)

Update `.env.development` with the client ID and key from each.

### Update Procfile

You can start your server in SSL mode; be sure to set your hostname properly!

```
rails: rails server --binding "ssl://dev.booker.jonmorton.me?key=$PWD/tmp/dev.key&cert=$PWD/tmp/dev.crt"
```

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
