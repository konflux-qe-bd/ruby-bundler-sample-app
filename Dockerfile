FROM registry.access.redhat.com/ubi9/ruby-33@sha256:c6604d380a2e3feb61182af12e1a54cfbc80f4b18c1e8faac66a97676e2d8dcb

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
