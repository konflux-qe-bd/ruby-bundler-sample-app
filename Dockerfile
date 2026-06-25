FROM registry.access.redhat.com/ubi9/ruby-33@sha256:4d70ffe948e72850706e1e23df90a6dbe8d7870d5085f7490a973ac561da6214

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
