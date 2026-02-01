FROM registry.access.redhat.com/ubi9/ruby-33@sha256:a10d440f1c7d821c7464d413c5a6d44bf166874b72e8c54895a25017715ae44f

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
