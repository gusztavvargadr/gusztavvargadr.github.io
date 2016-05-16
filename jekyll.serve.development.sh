#!/bin/bash

bundle exec jekyll serve --config=_config.yml,_config.development.yml --watch --force_polling --host 0.0.0.0 --incremental --drafts
