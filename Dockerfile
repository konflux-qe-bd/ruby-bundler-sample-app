FROM registry.access.redhat.com/ubi9/ruby-33@sha256:a0a566017ece84adcb7678b2ccdcc7a2ba88528a445242cb1c060375e6782493

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
