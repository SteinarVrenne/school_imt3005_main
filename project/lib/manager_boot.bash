#!/bin/bash -v

export DEBIAN_FRONTEND=noninteractive

# install Puppet and make sure its services are stopped
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1

i=0;
wget -O "$tempdeb" https://apt.puppetlabs.com/puppet6-release-bionic.deb
ret="$?"
while [ "$i" -lt "5" ] && [ "$ret" -ne "0" ]; do
  wget -O "$tempdeb" https://apt.puppetlabs.com/puppet6-release-bionic.deb
  ret="$?"
  let "i++"
done
if [ "$ret" -ne "0" ]; then # All attempts to download file failed, instruct clound-init to restart and try again
  exit 1003
fi


dpkg -i "$tempdeb"
apt-get update
apt-get -y install puppetserver git pwgen
/opt/puppetlabs/bin/puppet resource service puppet ensure=stopped enable=true
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=stopped enable=true

# configure local name resolution while waiting for DNS to work
echo "$(/opt/puppetlabs/bin/facter networking.ip) $(hostname).node.consul $(hostname)" >> /etc/hosts

# configure Puppet to run every five minutes
/opt/puppetlabs/bin/puppet config set server manager.node.consul --section main
/opt/puppetlabs/bin/puppet config set runinterval 300 --section main

# configure puppetserver to accept all new agents automatically
/opt/puppetlabs/bin/puppet config set autosign true --section master
/opt/puppetlabs/bin/puppetserver ca setup

# install and configure r10k
# @TODO - Change the main branch of the control repo to production!
/opt/puppetlabs/bin/puppet module install puppet-r10k
cat <<EOF > /var/tmp/r10k.pp
class { 'r10k':
  sources => {
    'puppet' => {
      'remote'  => 'https://bitbucket.org/Jimbob21148/control-repo.git',
      'basedir' => '/etc/puppetlabs/code/environments',
      'prefix'  => false,
    },
  },
}
EOF
/opt/puppetlabs/bin/puppet apply /var/tmp/r10k.pp

# deploy the Puppet code based on the control repository
# (roles, profiles, hieradata and all component modules)
r10k deploy environment -p

# copy global Hiera config in place (this is needed because its only
# in the global Hiera config it is allowed to use absolute path in datadir)
cd /etc/puppetlabs/code/environments/production/ || exit
cp global_hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

# if additional first time scripts needed, e.g. do
bash ./new_keys_and_passwds.bash
#
# only needed for now is some module "hacks"
/opt/puppetlabs/puppet/bin/gem install lookup_http
/opt/puppetlabs/bin/puppetserver gem install lookup_http
cd /etc/puppetlabs/code/environments/production/modules || exit
git clone https://github.com/ppouliot/puppet-dns.git
mv puppet-dns dns

# start puppetserver and let puppet configure the rest of manager
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
/opt/puppetlabs/bin/puppet agent -t # request certificate
/opt/puppetlabs/bin/puppet agent -t # configure manager
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

# Install openstack client and source our .rc file
apt install python-openstackclient -y
# @TODO source rc.sh file so we can contact OpenStack - ported over


# Adding openRC file to manager
echo '#!/usr/bin/env bash
# To use an OpenStack cloud you need to authenticate against the Identity
# service named keystone, which returns a **Token** and **Service Catalog**.
# The catalog contains the endpoints for all services the user/tenant has
# access to - such as Compute, Image Service, Identity, Object Storage, Block
# Storage, and Networking (code-named nova, glance, keystone, swift,
# cinder, and neutron).
#
# *NOTE*: Using the 3 *Identity API* does not necessarily mean any other
# OpenStack API is version 3. For example, your cloud provider may implement
# Image API v1.1, Block Storage API v2, and Compute API v2.0. OS_AUTH_URL is
# only for the Identity API served through keystone.
export OS_AUTH_URL=https://api.skyhigh.iik.ntnu.no:5000
# With the addition of Keystone we have standardized on the term **project**
# as the entity that owns the resources.
export OS_PROJECT_ID=558e4d15f6ce4414a1df6c9aba50bee2
export OS_PROJECT_NAME="IMT3005_H20_G04"
export OS_USER_DOMAIN_NAME="Default"
if [ -z "$OS_USER_DOMAIN_NAME" ]; then unset OS_USER_DOMAIN_NAME; fi
export OS_PROJECT_DOMAIN_ID="cb782810849b4ce8bce7f078cc193b19"
if [ -z "$OS_PROJECT_DOMAIN_ID" ]; then unset OS_PROJECT_DOMAIN_ID; fi
# unset v2.0 items in case set
unset OS_TENANT_ID
unset OS_TENANT_NAME
# In addition to the owning entity (tenant), OpenStack stores the entity
# performing the action as the **user**.
export OS_USERNAME="IMT3005_H20_G04_service"
# With Keystone you pass the keystone password.
#echo "Please enter your OpenStack Password for project $OS_PROJECT_NAME as user $OS_USERNAME: "
#read -sr OS_PASSWORD_INPUT
export OS_PASSWORD="kTR3pUmUFOWd"
# If your configuration has multiple regions, we set that information here.
# OS_REGION_NAME is optional and only valid in certain environments.
export OS_REGION_NAME="SkyHiGh"
# Dont leave a blank variable, unset it if it was empty
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3' > /root/openRC.sh

# shellcheck source=/root/openRC.sh
source /root/openRC.sh

# Script to allow webserver to SSH to manager when a container has been requested
bash /etc/puppetlabs/code/environments/production/add_authorized_key.bash

# Script adding parameters to host_machine config file
bash /etc/puppetlabs/code/environments/production/addToConfig.sh
