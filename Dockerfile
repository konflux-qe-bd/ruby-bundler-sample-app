FROM registry.access.redhat.com/ubi9/ruby-33@sha256:505cf76b491af285dcbb2272bb24b43d16be2711e709b973deb382ce9d34131f

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
