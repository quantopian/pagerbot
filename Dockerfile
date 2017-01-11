FROM ruby:2.2

RUN apt-get update; apt-get install libgmp3-dev --assume-yes
RUN mkdir /pagerbot

WORKDIR /pagerbot
ADD Gemfile* *.gemspec /pagerbot/
RUN bundle install
ADD . /pagerbot

ENV MONGODB_URI 'mongodb://mongo:27017/pagerbot'

EXPOSE 4567

CMD ["rerun", "-b", "--", "ruby", "lib/pagerbot.rb", "admin", "--host", "0.0.0.0"]
