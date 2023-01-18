FROM ubuntu
RUN apt-get update && apt-get install -y ruby-full rubygems mysql-server
RUN sudo apt install lsb-release
RUN curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

RUN sudo apt-get update
RUN sudo apt-get install redis

RUN gem install rails
RUN gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/'
RUN bundle exec bin/rails active_storage:install
RUN bundle exec bin/rails db:create db:migrate
