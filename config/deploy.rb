# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'kaixin'
set :repo_url, 'git@github.com:jimhj/kaixin.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "~/www/#{fetch(:application)}/"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/config.yml', 'config/unicorn.rb')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :rails_env, :production

# Default value for keep_releases is 5
set :keep_releases, 5

set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }

namespace :unicorn do

  task :start do
    on roles(:web, :db, :app) do
      within release_path do
        with rails_env: 'production' do
          execute :bundle, 'exec unicorn_rails -c config/unicorn.rb -D' 
        end
      end
    end
  end

  task :stop do
    on roles(:web, :db, :app) do
      execute :kill, "-s QUIT `cat #{fetch(:unicorn_pid)}`"
    end
  end

  task :restart do
    on roles(:web, :db, :app) do
      execute :kill, "-s USR2 `cat #{fetch(:unicorn_pid)}`"
    end    
  end

  task :reload do
    on roles(:web, :db, :app) do
      execute :kill, "-s HUP `cat #{fetch(:unicorn_pid)}`"
    end     
  end

  task :force_reload do
    on roles(:web, :db, :app) do
      execute :kill, "-s TERM `cat #{fetch(:unicorn_pid)}`"
      invoke 'unicorn:start'
    end
  end
end

namespace :deploy do
  after :finished, 'unicorn:force_reload' 
end