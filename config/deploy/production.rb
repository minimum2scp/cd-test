set :branch, (ENV['BRANCH'] || fetch(:branch, 'master'))

server '172.17.0.7', user: 'debian', roles: %w[app db web]

