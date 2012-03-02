#Site5 specific stuff
set :use_sudo, false
set :group_writable, false
 
# Less releases, less space wasted
set :keep_releases, 2
 
# The mandatory stuff
set :application, "calendar"
set :user, "thearmny"

#Git info
default_run_options[:pty] = true
set :repository, "git://github.com/jparsons/scheduler.git"
set :scm, "git"
set :branch, "the_arm_redesign"
#set :deploy_via, :remote_cache
 
# This is related to site5 too.
set :deploy_to, "/home/#{user}/#{application}"
role :app, "thearmnyc.com"
role :web, "thearmnyc.com"
role :db, "thearmnyc.com", :primary => true
 
# Create Site5 specific tasks
namespace :deploy do
  desc "Deploy app, run migrations, and start Phusion Passenger"
  task :cold do
    update
    site5::link_public_html
    site5::link_environment_rb  
    site5::link_vendored_gems
    restart
  end
  
  desc "Copy the environment.rb file that has the relative_url setting"
  task :copy_environment_rb do
    run "rm #{current_path}/config/environment.rb; cp #{current_path}/config/environment.rb.deploy #{current_path}/config/environment.rb"
  end
 
  desc "Restart Phusion Passenger"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Start application -- not needed for Passenger"
  task :start, :roles => :app do
    #nothing, needs to be blank to make Passenger work properly
  end
 
  namespace :site5 do
    desc "Link the public folder of the application to public_html"
    task :link_public_html do
      run "cd /home/#{user};  ln -s #{current_path}/public ./public_html/dev.thearmnyc.com/#{application}"
    end
    desc "Link the environment.rb file"
    task :link_environment_rb do
      run "cd #{current_path}/config; rm #{current_path}/config/enviroment.rb; ln -s #{shared_path}/config/environment.rb environment.rb"
    end
    desc "link to shared gems"
    task :link_vendored_gems do
      run "cd #{current_path}/vendor; ln -s #{shared_path}/gems gems"
    end
  end
end

before "deploy:setup", :db
after "deploy:update_code", "db:symlink" 
before "deploy:restart", "deploy:link_environment_rb"

namespace :db do

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
  

end