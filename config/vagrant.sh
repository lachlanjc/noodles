#!/usr/bin/env bash

log () {
  echo -e "\n\e[35m-----> $1\n"
}

log "Updating Aptitude"
apt-get update

log "Installing the basics"
apt-get install curl python-software-properties -y

log "Installing and updating gems"
bundle update
bundle install

log "Setting up Noodles"

# Get into the Vagrant directory
cd vagrant

# TODO: Make sure this happen in the vbox
sudo chmod -R g+ws /opt/ruby
sudo chown -R root:admin /opt/ruby

# Bundle
su vagrant -lc "cd /vagrant && bundle install"

# Setup .env
cp .env.example .env -n

log "Setting up the database"
cd ..
cp config/database.yml.example config/database.yml &&
su vagrant -lc "cd /vagrant && bundle exec rake db:create"
su vagrant -lc "cd /vagrant && bundle exec rake db:migrate"
su vagrant -lc "cd /vagrant && bundle exec rake db:seed"

# log "Starting Noodles"
# su vagrant -lc "cd /vagrant && sudo foreman export upstart /etc/init \
#   --app noodles \
#   --user vagrant \
#   --log /vagrant/log \
#   --template /vagrant/config/vagrant/foreman/export_templates/upstart"

# if ! restart noodles 2> /dev/null ; then
#    start noodles;
# fi

# Print out a little message

cat <<EOF
-------------------------------------------------------------------------------
Noodles

Noodles has been successfully installed.

Open up http://localhost:2201 in your browser to get started.

-------------------------------------------------------------------------------
EOF
