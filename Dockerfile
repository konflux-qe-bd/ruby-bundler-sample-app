FROM registry.access.redhat.com/ubi9/ruby-33@sha256:1269cf9fc8c22d2b8192ae1b7d46824cbe6e64839090f11ae04a94a2826eab93

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
