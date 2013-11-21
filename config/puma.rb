# rails_env = ENV['RAILS_ENV'] || 'development'
threads 4,8

bind  "unix:///home/institut/egret/ocs/shared/tmp/puma/ocs-puma.sock"
pidfile "/home/institut/egret/ocs/shared/tmp/puma/pid"
state_path "/home/institut/egret/ocs/shared/tmp/puma/state"

stdout_redirect '/home/institut/egret/ocs/shared/log/puma.access.log', '/home/institut/egret/ocs/shared/log/puma.error.log', true

activate_control_app "unix:///home/institut/egret/ocs/shared/tmp/puma/pumactl.sock"
daemonize true