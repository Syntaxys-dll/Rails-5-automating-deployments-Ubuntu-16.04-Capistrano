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

### Step 6

Run playbook install. Change ip to your server.

`cd config/provision && ansible-playbook -i188.226.255.173, playbook.yml`

### Step 7

Run:

`cap production deploy`
