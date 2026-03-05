FROM registry.access.redhat.com/ubi9/ruby-33@sha256:1a7fbaa7c47b82da38dbfb8d83dc3f921f96879849c2b5d3be46b6bdfd809094

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
