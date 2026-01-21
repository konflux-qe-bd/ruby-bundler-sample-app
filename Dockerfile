FROM registry.access.redhat.com/ubi9/ruby-33@sha256:cdb77b69ea7164798aa2f01f1736725b7d790c68def3853b7878f20a4cfd17ed

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
