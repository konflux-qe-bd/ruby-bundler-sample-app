FROM registry.access.redhat.com/ubi9/ruby-33@sha256:23592b0e8098fe60894bf0bd99e04786a662f8872d3fc244a27020de8f323b94

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
