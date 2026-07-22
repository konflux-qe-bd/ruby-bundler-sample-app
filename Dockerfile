FROM registry.access.redhat.com/ubi9/ruby-33@sha256:25e92dbff98bb92331e6c6d8e37c720f32b384e94ca62f0281abf3946849c202

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
