#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm

gem update --system
gem install bundler

bundle install --gemfile=/vagrant/Gemfile
