FROM ruby:2.6.3:alpine

RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
