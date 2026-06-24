FROM registry.access.redhat.com/ubi9/ruby-33@sha256:cc0c683c7353f8f67e17be436d9a11a40ecaaa7839f479cb332aba55485ab270

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
