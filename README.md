# BOOKER

[![build](https://travis-ci.org/jmorton/booker.svg?branch=master)](https://travis-ci.org/jmorton/booker)
[![security](https://hakiri.io/github/jmorton/booker/master.svg)](https://hakiri.io/github/jmorton/booker/master)

## Intro

Booker is a Reservation system based on Rails 5. It's not used in the real-world
for anything (as far as I know) but it should help you answer a variety of questions
about how to build something similar. It's also a pretty good way for you to
figure out if I actually know how to build things.

Learn more about the [data model](docs/data_model.md) and [interesting problems](docs/dragons.md).


## Setup

See our [Ubuntu Setup](docs/setup_ubuntu.md) documentation.

## Tests

Basic tests are run like this:

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

## License

(c) Jonathan Morton 2018 – MIT License
