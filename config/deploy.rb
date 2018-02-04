# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "online_blogs"
set :repo_url, "git@github.com:WadeJG/online_blogs.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH'] || "master"
# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/root/online_blogs"
# Default value for :format is :airbrussh.
# set :format, :airbrussh

set :rails_env, ENV['RAILS_ENV'] || ENV['rails_env']
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sessions", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
namespace :deploy do
  task :restart do
    invoke "deploy:unicorn_mine:reload"
  end
end

after 'deploy:publishing', 'deploy:restart'
