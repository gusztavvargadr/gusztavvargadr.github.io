#!/usr/bin/env bash

# curl
sudo apt-get update
sudo apt-get install -y curl

# Ruby and RubyGems
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable --ruby
source /home/vagrant/.rvm/scripts/rvm

gem update --system

# NodeJS
sudo apt-get install -y nodejs

# Python 2.7
sudo apt-get install -y python2.7

# Jekyll
bundle install --gemfile=/vagrant/Gemfile
