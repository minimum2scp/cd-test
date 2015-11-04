#! /bin/bash -l

set -e
set -x

export -p
pwd
ls -la


mkdir -p vendor/bundle
bundle install --path=vendor/bundle --jobs=4 --without development:test
bundle exec cap ${DEPLOY_ENV} deploy BRANCH=${BRANCH}
