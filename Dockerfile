FROM registry.access.redhat.com/ubi9/ruby-33@sha256:35ef1efd386a76038ff4704c50f23f0fc78f26f23e4ed348b43cb26b1ca7c84e

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
