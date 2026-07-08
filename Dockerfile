FROM registry.access.redhat.com/ubi9/ruby-33@sha256:2cdc1017033ffe9a0b3d811681dde78f7f991ea7ef7a3c8a68deae3d3ea5143c

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
