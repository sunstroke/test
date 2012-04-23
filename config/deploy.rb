# -*- encoding : utf-8 -*-
set :application, "fabrika"
#set :repository,  "git@fcross.ru:photocross.git"
set :repository,  "git://gitorious.org/fabrika/fabrika.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/home/photocross"
set :deploy_to, "/var/www/rails/fabrika"


set :scm, :git
ssh_options[:paranoid] = false

role :web, "photocross.ru"
role :app, "photocross.ru"
role :db,  "photocross.ru", :primary => true

set :user, "webmaster"


namespace :deploy do

  desc "Deploys your project."
  task :default do
    update
    restart
  end


  desc "Task that updates running code"
  task :update, :roles => :app do
    run "cd #{deploy_to} && git pull"
  end
  desc "Task that install gems"
  task :gems, :roles => :app do
    run "cd #{deploy_to}  ; RAILS_ENV=production bundle install"
  end
  desc "Task that run current migrations"
  task :migrate, :roles => :db do
    # run "cd #{deploy_to} ; PATH=$PATH:/var/lib/gems/1.8/bin RAILS_ENV=production rake db:migrate"
    run "cd #{deploy_to} && RAILS_ENV=production rake db:migrate"
   # run "cd #{deploy_to} ; mongrel_rails restart "
  end
  
  before "deploy:migrate", :roles => :app do
    update
  end
  
  after "deploy:migrate", :roles => :app do
    restart
  end
  
  before "deploy:restart", :roles => :app do
    run "cd #{deploy_to}; rm -f public/stylesheets/cache/*.css public/javascripts/cache/*.js"
  end
  
  desc "Restart application"
  task :restart do
    run "cd #{deploy_to} ; mkdir -p tmp && touch tmp/restart.txt"
  end

  desc "The spinner task is used by :cold_deploy to start the application up"
  task :spinner, :roles => :app do
  end
  
  desc "checkout schema.rb"
  task :checkout, :roles => :app do
    run "cd #{deploy_to} && git checkout db/schema.rb"
  end  
  
  desc "logfile production.log"
  task :log, :roles => :app do
    run "cd #{deploy_to} && cat log/production.log"
  end  

  desc "delete logfile production.log"
  task :rm, :roles => :app do
    run "cd #{deploy_to} && rm log/production.log"
  end
end
