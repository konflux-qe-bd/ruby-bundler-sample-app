FROM registry.access.redhat.com/ubi9/ruby-33@sha256:20a89c93faa5a694810d64a7423620d79cfc8fab8e6829337e1b4f0048a024ef

WORKDIR /app

RUN chmod 775 /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

RUN bundle binstubs rspec-core

CMD ["bin/rspec"]
