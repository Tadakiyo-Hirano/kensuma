FROM ruby:3.0.3

# Node.jsをインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt update && apt install -y yarn

# その他ツールインストール
RUN apt-get update && apt-get install -y yarn vim && \
    apt-get install -y graphviz

# rmagickのgemを使用する前提でimagemagickを入れておく必要がある。
RUN apt-get update -qq && apt-get install -y imagemagick

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /webapp
WORKDIR /webapp

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

# bundle installの実行
RUN bundle install -j4

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /webapp

# アセットのプリコンパイル
RUN SECRET_KEY_BASE=placeholder RAILS_ENV=production bundle exec rails assets:precompile \
 && yarn cache clean \
 && rm -rf node_modules tmp/cache

EXPOSE 3000

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"
