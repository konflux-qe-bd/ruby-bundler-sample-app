FROM registry.access.redhat.com/ubi9/ruby-33@sha256:5bb8bf278ea34a4d9dc15a7d996383cda277ab80ed8d7873429ddf4a23aea2d6

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
