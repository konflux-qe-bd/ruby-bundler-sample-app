FROM registry.access.redhat.com/ubi9/ruby-33@sha256:8e73832e018bc90dad60a97b17a8cdcf8287ac2ff9789001debad75daece8fc6

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
