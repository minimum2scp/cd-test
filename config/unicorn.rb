worker_processes 2

rails_root = File.expand_path("../..", __FILE__)

listen "#{rails_root}/tmp/sockets/unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30
pid "#{rails_root}/tmp/pids/unicorn.pid"

stderr_path "#{rails_root}/log/unicorn.stderr.log"
stdout_path "#{rails_root}/log/unicorn.stdout.log"
preload_app true

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = '/var/www/cd-test/current/Gemfile'
  Dotenv.overload
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
