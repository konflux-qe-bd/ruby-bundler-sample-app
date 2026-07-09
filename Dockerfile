FROM registry.access.redhat.com/ubi9/ruby-33@sha256:e080467bef3886664c31f803e6e86ee29df002d3c4de857317e23ab0a1c7ad3e

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
