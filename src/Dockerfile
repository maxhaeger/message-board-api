FROM --platform=linux/amd64 ruby:3.1.2

COPY . .
RUN bundle install
CMD bundle exec ruby server.rb
EXPOSE 4567

