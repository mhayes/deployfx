RAILS_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))

# require 'capistrano/ext/multistage'
require "bundler/capistrano"

# use local key for authentication
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :application, "deployfx"
set :deploy_to, "/var/www/deployfx"
set :repository,  "git@github.com:mhayes/deployfx.git"
set :branch, "master"

server = "muggle.in"
role :app, server
role :web, server
role :db, server, :primary => true
set :rails_env, 'production'

set :deploy_via, :remote_cache
set :scm, "git"
set :use_sudo, false
set :user, "deployfx"

before "deploy:assets:precompile", "deploy:link_config_files"
after "deploy:update_code", "deploy:link_config_files"

set :keep_releases, 3
after "deploy:update", "deploy:cleanup"

namespace :deploy do
  desc "Symlink production config files"
  task :link_config_files do
    config_files = Dir.glob(Pathname.new(RAILS_ROOT).join("config", "*.yml.sample"))
    config_files.each do |file|
      f = File.basename(file, ".yml.sample")
      run "ln -nfs #{shared_path}/config/#{f}.yml #{release_path}/config/#{f}.yml" 
    end
    
    run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  end
end

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

after "deploy:restart", "unicorn:reload"
set :unicorn_binary, "bundle exec unicorn"
set :unicorn_config, "config/unicorn.rb"
set :unicorn_pid, "/tmp/unicorn.deployfx.pid"
namespace :unicorn do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end