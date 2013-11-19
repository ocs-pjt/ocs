# rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,8

bind  "unix:///home/institut/egret/ocs/shared/tmp/puma/ocs-puma.sock"
pidfile "/home/institut/egret/ocs/current/tmp/pids"
state_path "/home/institut/egret/ocs/current/tmp/sockets"

stdout_redirect '/home/institut/egret/ocs/current/log/puma.access.log', '/home/institut/egret/ocs/current/log/puma.error.log', true

activate_control_app
daemonize true