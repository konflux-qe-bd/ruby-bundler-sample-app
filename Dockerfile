FROM registry.access.redhat.com/ubi9/ruby-33@sha256:e83dc3c410999b7de69c893b2eb197cd78f5c56f22e8e212f9cfb0c662657a4c

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
