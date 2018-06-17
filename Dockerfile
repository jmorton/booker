FROM ruby:2.5
MAINTAINER Jonathan Morton

ENV RAILS_ENV production

ENV BOOKER_DATABASE_HOST     database
ENV BOOKER_DATABASE_NAME     booker
ENV BOOKER_DATABASE_USERNAME booker
ENV BOOKER_DATABASE_PASSWORD booker

EXPOSE 3000

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /booker

WORKDIR /booker

# Might it make better sense to selectively copy files?
#
# ADD  Gemfile*      /booker/
# ADD  package.json  /booker/
# ADD  yarn.lock     /booker/
# ADD  config.ru     /booker/
# ADD  app           /booker/
# ADD  config        /booker/
# ADD  db            /booker/
# ADD  bin           /booker/
# ADD  public        /booker/


ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

ADD . .
RUN yarn install
RUN bundle exec rails assets:precompile

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
