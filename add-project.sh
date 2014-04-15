#!/usr/bin/env bash

die() {
   [[ $# -gt 1 ]] && { 
	    exit_status=$1
        shift        
    } 
    printf >&2 "ERROR: $*\n"

    exit ${exit_status:-1}
}

trap 'die $? "*** add-project failed. ***"' ERR
set -o nounset -o pipefail

# Create an example project and 
rd-project -a create -p example --project.ssh-keypath=/var/lib/rundeck/.ssh/id_rsa


# Run simple commands to double check.
# Print out the available nodes.
# Fire off a command.
dispatch -p example
dispatch -p example -f -- whoami

cp /vagrant/provision/nodes.xml /var/rundeck/projects/example/etc/resources.xml
chown rundeck:rundeck /var/rundeck/projects/example/etc/resources.xml

mkdir -p /var/lib/rundeck/.ssh/
cp /vagrant/provision/id_rsa* /var/lib/rundeck/.ssh/
chown rundeck:rundeck /var/lib/rundeck/.ssh
chown rundeck:rundeck /var/lib/rundeck/.ssh/*


for i in `ls /vagrant/provision/jobs/*.xml` ; do
rd-jobs load -p example -f ${i}
done