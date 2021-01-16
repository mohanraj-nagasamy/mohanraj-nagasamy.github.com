FROM jekyll/jekyll:4.2.0
EXPOSE 4000

WORKDIR /app
COPY . .

RUN gem install jekyll bundler
RUN bundle install

# bundle exec jekyll serve

# docker build -f Dockerfile -t jekyll_dev .
# docker run -p 4000:4000 -v /$(pwd):/app -it jekyll_dev /bin/bash
# jekyll serve
# Before pusing to github
# `jekyll b -d docs`
