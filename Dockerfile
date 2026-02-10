FROM registry.access.redhat.com/ubi9/ruby-33@sha256:04b3b5108623438d4ac9d9f5e776bf0cabc0d94a146fc3cc7ed74e84b43a6eaa

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
