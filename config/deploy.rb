# config valid only for current version of Capistrano
lock '3.4.0'

require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, 'dropresume-blog'
set :repository,  'git@bitbucket.org:byte-logistics/blog.git'
set :scm, :git
set :deploy_via, :remote_cache    #comment this line when deploy for first time
set :keep_releases, 10
set :rvm_ruby_string, 'ruby-2.1.5'
set :rvm_type, :user
set :rake, 'bundle exec rake'
set :user, 'deployer'
set :use_sudo, true
set :bundle_cmd, 'bundle'

#the user of the server which will run commands on server
default_run_options[:pty] = true
ssh_options[:port] = 22
ssh_options[:username] = 'tauhidul35@gmail.com'
ssh_options[:host_key] = 'ssh-dss'
ssh_options[:paranoid] = false
ssh_options[:forward_agent] = true

# end of default configuration
task :link_shared_files, :roles => :app do
  run "rm -rf #{current_path}/public/uploads; ln -s #{shared_path}/uploads #{current_path}/public/uploads"
end

task :production do
  set :branch, 'master'
  set :deploy_to, '/home/deployer/apps/dropresume-blog/'
  set :rails_env, 'production'
  web_server = '104.131.62.206'
  set :application, web_server
  set :application, web_server
  role :web, web_server                          # Your HTTP server, Apache/etc
  role :app, web_server                          # This may be the same as your `Web` server
  role :db,  web_server, :primary => true        # This is where Rails migrations will run
  set :keep_releases, 5
end

task :staging do
  set :branch, 'development'
  set :deploy_to, '/home/deployer/apps/dropresume-blog/'
  set :rails_env, 'staging'
  web_server = '128.199.188.61'
  set :application, web_server
  role :web, web_server                          # Your HTTP server, Apache/etc
  role :app, web_server                          # This may be the same as your `Web` server
  role :db,  web_server, :primary => true        # This is where Rails migrations will run
  set :keep_releases, 5
end

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end

  task :stop do ; end

  desc 'Restart the application'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :create_shared_files_and_directories, :role => :app do
    run "mkdir -p #{shared_path}/config/.bundle"
    run "mkdir -p #{shared_path}/bundle"
    run "touch #{shared_path}/config/.bundle/config"
    run "mkdir -p #{shared_path}/uploads"
    run "mkdir -p #{shared_path}/assets"
  end

  desc 'Copy the database.yml file into the latest release'
  task :copy_in_database_yml do
    run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
    run "cp #{shared_path}/config/secrets.yml #{latest_release}/config/"
    # run "cp #{shared_path}/config/application.yml #{latest_release}/config/"
  end
end

before 'deploy:assets:precompile', 'deploy:copy_in_database_yml'
after 'deploy:update_code', 'deploy:migrate'
after 'deploy:setup', 'deploy:create_shared_files_and_directories'
after 'deploy:create_symlink', :link_shared_files
after 'deploy:update', 'deploy:cleanup'
