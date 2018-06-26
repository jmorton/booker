# BOOKER

[![build](https://travis-ci.org/jmorton/booker.svg?branch=master)](https://travis-ci.org/jmorton/booker)
[![security](https://hakiri.io/github/jmorton/booker/master.svg)](https://hakiri.io/github/jmorton/booker/master)

## Intro

Booker is a Reservation system based on Rails 5. It's not used in the real-world
for anything (as far as I know) but it should help you answer a variety of questions
about how to build something similar. It's also a pretty good way for you to
figure out if I actually know how to build things.

Learn more about the [data model](docs/data_model.md) and [interesting problems](docs/think.md)
encountered while building this system.

## Setup

See our [Ubuntu Setup](docs/setup_ubuntu.md) documentation.

## Tests

Basic tests are run like this:n

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

## Development Server

Start the development server using Foreman.

```
bundle exec foreman start
```

## License

(c) Jonathan Morton 2018 – MIT License
