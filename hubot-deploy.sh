#! /bin/sh

set -e
set -x

export -p
pwd
ls -la

bundle exec cap ${DEPLOY_ENV} deploy BRANCH=${BRANCH}
