FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN apt-get update && apt-get install -y unzip && \
CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ && \
unzip ~/chromedriver_linux64.zip -d ~/ && \
rm ~/chromedriver_linux64.zip && \
chown root:root ~/chromedriver && \
chmod 755 ~/chromedriver && \
mv ~/chromedriver /usr/bin/chromedriver && \
sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
apt-get update && apt-get install -y google-chrome-stable


RUN mkdir /portfolio

WORKDIR /portfolio

ADD Gemfile /portfolio/Gemfile

ADD Gemfile.lock /portfolio/Gemfile.lock

RUN bundle install

ADD . /portfolio

RUN mkdir -p tmp/sockets