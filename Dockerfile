FROM ruby:2.5
MAINTAINER Jonathan Morton

EXPOSE 3000

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /booker

WORKDIR /booker

ADD Gemfile       .
ADD Gemfile.lock  .
RUN bundle install --without development test

ADD package.json  .
ADD yarn.lock     .
RUN yarn install

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
# !!  WARNING: DO *NOT* INCLUDE config/master.key  !! #
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
#
#     The master.key must remain secret. Including
#     secrets in an image is risky because pushing
#     to a public repository is easy.
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #

ADD . .
RUN rm --force config/master.key

#
# Precompile JavaScript and CSS.
#

RUN bundle exec rails RAILS_ENV=production SECRET_KEY_BASE=didyoureallythinkitdbethateasy assets:precompile

#
# Configure the app with environment variables.
#

ENV SECRET_KEY_BASE=                \
    RAILS_ENV=production            \
    RAILS_LOG_TO_STDOUT=true        \
    RAILS_SERVE_STATIC_FILES=true   \

ENV BOOKER_DATABASE_HOST=       \
    BOOKER_DATABASE_NAME=       \
    BOOKER_DATABASE_USERNAME=   \
    BOOKER_DATABASE_PASSWORD=

ENV DISCORD_CLIENT_ID=          \
    DISCORD_CLIENT_SECRET=      \
    GOOGLE_CLIENT_ID=           \
    GOOGLE_CLIENT_SECRET=       \
    GITHUB_CLIENT_ID=           \
    GITHUB_SECRET=              \
    TWITTER_CLIENT_ID=          \
    TWITTER_SECRET=

ENV SPACES_KEY=         \
    SPACES_SECRET=      \
    SPACES_REGION=      \
    SPACES_BUCKET=      \
    SPACES_ENDPOINT=

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
