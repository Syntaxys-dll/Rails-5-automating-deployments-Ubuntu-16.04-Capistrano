# Deploy with Ansible on a new server:
#   $ (cd config/provision && ansible-playbook -i178.62.254.62, playbook.yml)
#   $ bundle exec cap production deploy
#   $ bundle exec cap production rake task=db:seed

lock '3.7.2'

set :application, 'test'
set :repo_url, 'git@github.com:Syntaxys-dll/Rails-5-automating-deployments-Ubuntu-16.04-Capistrano.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/applications/test'

set :log_level, :info
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :rbenv_path, '/home/deploy/.rbenv'
set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

set :puma_init_active_record, true

desc 'Run rake tasks on server'
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: :production do
        execute :rake, ENV['task'], 'RAILS_ENV=production'
      end
    end
  end
end
