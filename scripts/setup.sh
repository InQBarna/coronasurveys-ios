#!/bin/sh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# GEMS
export RUBY_VERSION="2.6.5"
export BUNDLER_VERSION="2.0.2"
export GEM_VERSION="3.0.3"
export PATH=/usr/local/bin/:$PATH
which rbenv || brew install rbenv
which gem | grep ".rbenv" || eval "$(rbenv init -)"
rbenv versions | grep "$RUBY_VERSION" || rbenv install $RUBY_VERSION
rbenv local $RUBY_VERSION
ruby --version | grep "$RUBY_VERSION" || exit -1
gem env | grep "RUBY VERSION: $RUBY_VERSION" || exit -1
gem install --user-install bundler:$BUNDLER_VERSION
bundle --version | grep "$BUNDLER_VERSION" || exit -1
bundle install
#bundle clean


bundle exec pod install || bundle exec pod install --repo-update || exit -1

