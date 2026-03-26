FROM registry.access.redhat.com/ubi9/ruby-33@sha256:7b80e999044b5850d26d1703385b2a5656036a68a100dd9fa23ff8ce6930d4dc

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
