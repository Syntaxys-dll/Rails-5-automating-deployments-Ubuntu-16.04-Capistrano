ip = '198.211.125.100'

role :app, ["root@#{ip}"]
role :web, ["root@#{ip}"]
role :db,  ["root@#{ip}"]

server ip, user: 'root', roles: %w{web app db}

set :stage, 'production'
set :rails_env, 'production'
