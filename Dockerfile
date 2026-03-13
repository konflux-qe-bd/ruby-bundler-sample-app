FROM registry.access.redhat.com/ubi9/ruby-33@sha256:c0785ca9aaa4665c5f042eac4aeb97c2e685f5f673e967427dbb5e078d26f299

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
