load 'deploy' if respond_to?(:namespace)

#Application
set :application, "epubcakes"

#Server
set :user, "asdfasdf"
set :port, 1234
set :use_sudo, false

#Git
set :scm, :git
set :git_user, "asdfasdf"
set :scm_passphrase, ""
set :repository, "git@github.com:#{git_user}/#{application}.git"
set :branch, "master"

role :app, "1.2.3.4"
role :web, "1.2.3.4"
role :db, "1.2.3.4", :primary => true

set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/public_html/#{application}"

set :runner, user
set :admin_runner, user

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "nohup beanstalkd -d -b #{deploy_to}/current/log"
    run "cd #{deploy_to}/current && nohup thin -C config/thin.yml -R config.ru start"
  end

  task :stop, :roles => [:web, :app] do
    run "killall beanstalkd"
    run "killall thin"
  end

  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end

  task :cold do
    deploy.update
    run "cd #{deploy_to}/current && bundle install"
    deploy.start
  end
end

namespace :epubcakes do
  task :log do
    run "cat #{deploy_to}/current/log/thin.log"
  end
end

