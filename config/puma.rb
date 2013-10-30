rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///home/institut/egret/ocs/shared/tmp/puma/ocs-puma.sock"
pidfile "/home/institut/egret/ocs/current/tmp/puma/pid"
state_path "/home/institut/egret/ocs/current/tmp/puma/state"

activate_control_app
daemonize true