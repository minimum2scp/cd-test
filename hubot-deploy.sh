#! /bin/bash -l

set -e
set -x

export -p
pwd
ls -la

mkdir -p vendor/bundle
rbenv exec bundle install --path=vendor/bundle --jobs=4 --without development:test
rbenv exec bundle exec cap ${DEPLOY_ENV} deploy BRANCH=${BRANCH}
