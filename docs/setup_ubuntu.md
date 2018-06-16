# Ubuntu Setup

This guide explains how to prepare a clean Ubuntu 16.04 system for development using Rails 5.2 circa 2018.

You will install:

1. Ruby: rbenv, ruby-build, Ruby 2.5.1, and Bundler.
2. Javascript: Node.js, and Yarn.
3. Services: PostgreSQL 10, Memcached, and Redis.

## Ruby

Install an arbitrary version of Ruby using `apt` then install `rbenv` and the `ruby-build` plugin to install a specific version of Ruby.

### Default Ruby

This install Ruby along with several dependencies typically needed when building Rails applications.

| Library          | What's it for?                            |
| =================| ========================================= |
| buildessential   | Compiling other libraries                 |
| libpq-dev        | PostgreSQL communication                  |
| libssl-dev       | Encryption                                |
| libreadline-dev  | Command line history                      |
| libvips-dev      | Image manipulation                        |
| zlib1g-dev       | Compression                               |


```
sudo apt update
sudo apt install -y ruby build-essential libssl-dev libreadline-dev zlib1g-dev libvips-dev libpq-dev
```

### rbenv

Learn more about [rbenv](https://github.com/rbenv/rbenv#readme)

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"'
source ~/.bashrc
```

### ruby-build

Learn more about [rbenv-build](https://github.com/rbenv/ruby-build#readme)

```
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

### Ruby 2.5.1

Install Ruby 2.5.1 and use it as the global version.

```
rbenv install 2.5.1
rbenv global 2.5.1
rbenv rehash
```

### Bundler

Learn more about [Bundler](https://bundler.io/)

```
gem install bundler --no-ri --no-rdoc
```

## Javascript

Rails 5.2 plays well with Javascript; install Node.js and Yarn.

### Node.js and Yarn

Learn more about [Node.js](https://nodejs.org/en/) and [Yarn](https://yarnpkg.com/en/).

```
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y nodejs yarn
```

## Services

Rails is often used with PostgreSQL, Redis, and Memcached. I use PostgreSQL 10.x just to stay current.


### Redis and Memcached

```
sudo apt install -y redis-server memcached
```

### PostgreSQL 10

Remove PostgreSQL 9.x if it's installed.

```
sudo apt remove --purge postgresql
```

Install PostgreSQL 10.x

```
curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
apt install -y postgresql-10
```

Create a user and DB.

```
sudo -u postgres createuser $(whoami); createdb $(whoami)
```

Grant privileges to yourself to manage DBs.

```
sudo -u postgres psql --command="alter role $(whoami) superuser createrole createdb replication;"
```

## Testing It Out

You should now be able to setup the database and run tests:

```
bundle install
bin/rails dbsetup
bin/rails test
bin/rails cucumber
```

You should be able to start the app in development mode too:

```
bundle exec foreman start
```
