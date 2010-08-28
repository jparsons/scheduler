#Site5 specific stuff
set :use_sudo, false
set :group_writable, false
 
# Less releases, less space wasted
set :keep_releases, 2
 
# The mandatory stuff
set :application, "scheduler"
set :user, "klondike"

#Git info
default_run_options[:pty] = true
set :repository, "git://github.com/jparsons/scheduler.git"
set :scm, "git"
set :branch, "master"
#set :deploy_via, :remote_cache
 
# This is related to site5 too.
set :deploy_to, "/home/#{user}/#{application}"
role :app, "klondikefive.com"
role :web, "klondikefive.com"
role :db, "klondikefive.com", :primary => true
 
# Create Site5 specific tasks
namespace :deploy do
  desc "Deploy app, run migrations, and start Phusion Passenger"
  task :cold do
    update
    site5::link_public_html
    site5::copy_environment_rb  
    
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
      run "cd /home/#{user};  ln -s #{current_path}/public ./public_html/#{application}"
    end
    

  
  
  end
end

before "deploy:setup", :db
after "deploy:update_code", "db:symlink" 
before "deploy:restart", "deploy:copy_environment_rb"

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    set :database_password do
      Capistrano::CLI.password_prompt "Database Password: "
    end
    db_config = ERB.new <<-EOF
    development:
      adapter: mysql
      database: andrew_catalog
      username: andrew_webuser
      password: #{database_password} 
      socket: /tmp/mysql.sock

    # Warning: The database defined as "test" will be erased and
    # re-generated from your development database when you run "rake".
    # Do not set this db to the same as development or production.
    test:
      adapter: sqlite3
      database: db/test.sqlite3
      pool: 5
      timeout: 5000

    production:
      adapter: mysql
      database: andrew_catalog
      username: andrew_webuser
      password: #{database_password} 
      socket: /tmp/mysql.sock
    EOF

    run "mkdir -p #{shared_path}/config" 
    put db_config.result, "#{shared_path}/config/database.yml" 
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
  

end