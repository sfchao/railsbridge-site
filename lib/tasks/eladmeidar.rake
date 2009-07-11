namespace :db do 
  desc "Change to Mysql for eladmeidar's dev machine"
  task :set_to_mysql  do
    config_path = File.join(RAILS_ROOT, 'config')
    `cp #{config_path}/database.yml #{config_path}/database.tmp`
    `rm #{config_path}/database.yml`
    `cp #{config_path}/database.yml.eladmeidar #{config_path}/database.yml`

  end
  
  task :set_to_postgres do
    config_path = File.join(RAILS_ROOT, 'config')
    `rm #{config_path}/database.yml`
    `cp #{config_path}/database.tmp #{config_path}/database.yml`
  end
end