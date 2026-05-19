FROM registry.access.redhat.com/ubi9/ruby-33@sha256:060b3959016585d4e68ced9f4caef4e8367ff0a957e5ce6252fca56b04c934b6

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
