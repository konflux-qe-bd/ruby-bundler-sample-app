FROM registry.access.redhat.com/ubi9/ruby-33@sha256:371556269f6542025ca8d51ed0551afa421ed7b5f71d645a0940bbf320ed23eb

WORKDIR /app

# Check if the build is performed in hermetic environment
# (without access to the internet)
RUN if curl -s example.com > /dev/null; then echo "build is not being performed in hermetic environment" && exit 1; fi

RUN chmod 775 /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

RUN bundle binstubs rspec-core

CMD ["bin/rspec"]
