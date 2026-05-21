FROM registry.access.redhat.com/ubi9/ruby-33@sha256:beaa13eb39850ac47d350ef8735ee81e8c95f8a7605ac5c24d599f948e019a0b

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
