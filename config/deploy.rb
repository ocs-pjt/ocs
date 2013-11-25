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
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 3
set :scm_verbose, false

namespace :deploy do
  task :start do
    on roles(:all) do 
      #execute "bundle exec puma -C config/puma.rb" 
    end
  end

  namespace :assets do
    desc 'Run the precompile assets task'
    task :precompile do 
      on roles(:web), :except => { :no_release => true } do
        within fetch(:release_path) do
          with rails_env: fetch(:rails_env) do
            execute :rake, 'assets:precompile'
          end
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      within(shared_path.join("tmp/puma")) do
        # execute 'pumactl -s state restart'
      end
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
      within(fetch(:release_path)) do 
        with rails_env: fetch(:rails_env) do
          execute :bundle
        end
      end
    end
  end
end

after 'deploy:updated', 'deploy:assets:precompile'