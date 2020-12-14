FROM ruby:2.5.3
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs postgresql-client
RUN mkdir /dailyposts
WORKDIR /dailyposts
COPY Gemfile /dailyposts/Gemfile
COPY Gemfile.lock /dailyposts/Gemfile.lock
RUN bundle install
COPY . /dailyposts

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]