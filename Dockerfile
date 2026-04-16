FROM registry.access.redhat.com/ubi9/ruby-33@sha256:e54ff8c3e1c217ad6f7a8e47032102af57d2b6da95ad9e2c33c872e6b55995d7

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
