source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'jekyll'
gem 'jekyll-sitemap'
gem 'octopress', '~> 3.0.0.rc.12'
gem 'github-pages', versions['github-pages']
gem "html-proofer"