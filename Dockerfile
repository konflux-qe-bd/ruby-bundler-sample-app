FROM registry.access.redhat.com/ubi9/ruby-33@sha256:150d722ce6407c72545a668b685e628a2bf78d1baea8b855fb41075ce7806364

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
