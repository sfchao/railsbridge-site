set :application, "railsbridge-site2"
set :repository,  "git://github.com/railsbridge/railsbridge-site.git"
set :user, "rbadmin"
set :use_sudo, true
set :deploy_via, :fast_remote_cache
set :scm, :git

# Customise the deployment
set :tag_on_deploy, false # turn off deployment tagging, we have our own tagging strategy

set :keep_releases, 6
after "deploy:update", "deploy:cleanup"
after "deploy:update", "deploy:link_config"

# directories to preserve between deployments
set :asset_directories, ['public/system/site_images']
    
namespace :deploy do
  desc "Re-link config files"
  task :link_config, :roles => :app do
    run "ln -nsf #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
end
