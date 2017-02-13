# Rails 5 automating deployments with ansible, capistrano, postgresql.

Tested on Ubuntu 16.04 

### Step 1

Setup SSH keys [(manual)](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

### Step 2

Install Ansible

```
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```
### Step 3

Download this repo and unzip.

### Step 4

Change in files:

**/config/deploy/production.rb**

`ip = 'enter_your_server_ip'`

**config/deploy.rb**

```

# Set your repository url
set :repo_url, 'https://github.com/Syntaxys-dll/Rails-5-auto-deploy-boilerplate.git'

# Set deploy directory
set :deploy_to, '/home/deploy/applications/test'

```

### Step 5

Add ssh keys from ~/.ssh to **yourappfolder**/config/provision/keys/
```
cp ~/.ssh/id_* config/provision/keys
```

### Step 6

Run playbook install. Change ip to your server.

`cd config/provision && ansible-playbook -i188.226.255.173, playbook.yml`

### Step 7

Touches your :linked_files, so they'll be created if they don't exist:

`cap production linked_files:touch`

### Step 8

Run:

`cap production deploy`

### Step 9

Generate [(secret_key_base)](http://stackoverflow.com/questions/23180650/how-to-solve-error-missing-secret-key-base-for-production-environment-rai). 

Or my solution:

1). Run on local project:

`RAILS_ENV=production rails secret`

2). Copy key, its like '2ac821f79e0ea3291e47db43a995bc7044c9dc20ea8d9b8f0c4' 

3). Connect to production server 

`ssh deploy@your_server_ip`

4). Open secrets.yml:

`nano /home/deploy/applications/YOUR_APP_NAME/shared/config/secrets.yml`

5). Paste code and save:

```
production:
  secret_key_base: 2ac821f79e0ea3291e47db43a995bc7044c9dc20ea8d9b8f0c4
```
6). Restart puma on local project:

`cap production puma:restart`
