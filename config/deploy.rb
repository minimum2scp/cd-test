# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'cd-test'
set :repo_url, 'git@github.com:minimum2scp/cd-test.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, %w[config/database.yml config/secrets.yml .env]

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

###
### capistrano-rbenv (https://github.com/capistrano/rbenv/)
###
set :rbenv_ruby,    '2.2.3'
set :rbenv_type,    :system
set :rbenv_path,    '/opt/rbenv'

###
### capistrano-bundler (https://github.com/capistrano/bundler)
###
set :bundle_jobs,      4
set :bundle_binstubs,  nil

###
### capistrano3-unicorn (https://github.com/tablexi/capistrano3-unicorn)
###
set :unicorn_pid,                  "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path,          nil
set :unicorn_restart_sleep_time,   10

namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end

  task :upload_shared do
    invoke 'deploy:upload_database_yml'
    invoke 'deploy:upload_secrets_yml'
    invoke 'deploy:upload_dotenv'
  end

  task :upload_database_yml do
    on roles(:app) do
      upload! 'config/database.yml', "#{shared_path}/config/database.yml"
    end
  end

  task :upload_secrets_yml do
    on roles(:app) do
      upload! 'config/secrets.yml', "#{shared_path}/config/secrets.yml"
    end
  end

  task :upload_dotenv do
    on roles(:app) do
      upload! '.env', "#{shared_path}/.env"
    end
  end
end

