FROM registry.access.redhat.com/ubi9/ruby-33@sha256:66af8333d4c34bd9a58e922627b7d07680124f43d80f8d0ecf48c9d373dd2729

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
