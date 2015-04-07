FROM ruby:2.2.1

RUN apt-get update && apt-get install -y redis-server --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4

COPY . /usr/src/app

EXPOSE 4567
CMD ["bundle", "exec", "foreman", "start"]
