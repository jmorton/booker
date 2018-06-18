FROM ruby:2.5
MAINTAINER Jonathan Morton

ENV RAILS_ENV production
ENV BOOKER_DATABASE_HOST     database
ENV BOOKER_DATABASE_NAME     booker
ENV BOOKER_DATABASE_USERNAME booker
ENV BOOKER_DATABASE_PASSWORD booker
ENV GOOGLE_CLIENT_ID         none
ENV GOOGLE_CLIENT_SECRET     none
ENV GITHUB_CLIENT_ID         none
ENV GITHUB_SECRET            none
ENV TWITTER_CLIENT_ID        none
ENV TWITTER_SECRET           none
ENV DISCORD_CLIENT_ID        none
ENV DISCORD_CLIENT_SECRET    none
ENV RAILS_LOG_TO_STDOUT      none
ENV RAILS_SERVE_STATIC_FILES none
ENV SECRET_KEY_BASE          none

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

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
