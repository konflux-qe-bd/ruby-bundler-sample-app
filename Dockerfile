FROM registry.access.redhat.com/ubi9/ruby-33@sha256:b52c972de849480d20de4f0d0b78a17bb0579b6d5f910951b7bcc46b0c10d2cf

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
