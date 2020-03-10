FROM ruby:2.5

# COMMONS
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# PROJECT
ENV DIR /proposalyse
RUN mkdir ${DIR}
COPY . ${DIR}

WORKDIR ${DIR}

ADD Gemfile ${DIR}/Gemfile
ADD Gemfile.lock ${DIR}/Gemfile.lock
RUN bundle install

RUN groupadd --gid 1000 -r nonroot && useradd --uid 1000 --no-log-init -r -g nonroot nonroot

EXPOSE 3000