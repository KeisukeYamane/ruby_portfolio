FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /portfolio

WORKDIR /portfolio

ADD Gemfile /portfolio/Gemfile

ADD Gemfile.lock /portfolio/Gemfile.lock

RUN bundle install

ADD . /portfolio

RUN mkdir -p tmp/sockets