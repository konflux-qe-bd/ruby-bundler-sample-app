FROM registry.access.redhat.com/ubi9/ruby-33@sha256:e3f10430a1ef95a69f19247a4582c99dc3183d3683136bb488c7a91d0863ee7b

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
