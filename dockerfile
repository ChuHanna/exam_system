FROM ruby:3.0.2

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

WORKDIR /myapp

RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN curl -o /usr/bin/framgia-ci https://raw.githubusercontent.com/framgia/ci-report-tool/master/dist/framgia-ci
RUN chmod +x /usr/bin/framgia-ci
RUN apt-get update
RUN apt-get install -y git yarn python3-pip

RUN pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [ ! -e /usr/bin/python ]; then ln -sf /usr/bin/python3 /usr/bin/python; fi

RUN pip3 install framgia-ci
RUN pip3 install cleo==0.6.8

COPY ./entrypoints/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["./entrypoints/entrypoint.sh"]

COPY Gemfile .
COPY Gemfile.lock .
COPY package.json .
COPY bin/yarn ./bin/yarn
RUN bundle install

COPY . .
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm
RUN npm install --global yarn
RUN npm install -g node-gyp
RUN yarn install

EXPOSE 3000

CMD ["bash"]
