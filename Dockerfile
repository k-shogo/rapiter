FROM ruby:2.2.1

RUN cd /usr/local/src/ && git clone https://github.com/seppo0010/rlite.git
RUN cd /usr/local/src/rlite && make all

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4

COPY . /usr/src/app

EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb", "-o","0.0.0.0"]
