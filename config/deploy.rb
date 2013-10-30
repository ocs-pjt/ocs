set :application, 'ocs'
set :repo_url, 'git@github.com:ocs-pjt/ocs.git'
set :user, 'egret'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/home/institut/#{fetch(:user)}/#{fetch(:application)}"
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 3
set :scm_verbose, false

namespace :deploy do
  task :start do
    on roles(:all) do 
      execute "bundle exec puma -C config/puma.rb" 
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before :updated, :bundle do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{release_path} && bundle install"
    end
  end

  after :finishing, 'deploy:cleanup', 'deploy:start'
end

