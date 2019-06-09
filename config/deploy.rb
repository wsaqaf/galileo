# config valid for current version and patch releases of Capistrano
# config valid only for Capistrano 3.11
# require 'capistrano/ext/multistage'
lock "~> 3.11.0"

set :stages, ["production"]
set :default_stage, "production"

task :update_to_latest_version do
  execute "cd /var/www/faktaassistenten/"+ENV["DEPLOY_INSTANCE"]
  execute ". update.sh"
end

after "deploy:updated", "deploy:print_server_name"
