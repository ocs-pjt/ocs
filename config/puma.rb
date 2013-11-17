# rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

# bind  "unix:///home/institut/egret/ocs/shared/tmp/puma/ocs-puma.sock"
# pidfile "/home/institut/egret/ocs/current/tmp/puma/pid"
# state_path "/home/institut/egret/ocs/current/tmp/puma/state"

# stdout_redirect '/home/institut/egret/ocs/current/log/puma.access.log', '/home/institut/egret/ocs/current/log/puma.error.log', true

activate_control_app
# daemonize true