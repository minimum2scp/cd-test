#! /bin/bash -l

set -e
set -x

export -p
pwd
ls -la

unset GEM_HOME GEM_PATH RUBYLIB RUBYOPT
rbenv exec gem env
export -p
ssh-add -l

mkdir -p vendor/bundle
rbenv exec bundle install --path=vendor/bundle --jobs=4 --without development:test
rbenv exec bundle exec cap --trace ${DEPLOY_ENV} deploy BRANCH=${BRANCH}
