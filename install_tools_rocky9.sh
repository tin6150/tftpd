
#!/bin/bash 


# script to install various tools (via yum mostly/only)
# to be called by Dockerfile 
# and future by Singularity def file

# need to update package name to rockylinux 9 naming
# 1 package install at a time would be slower but easier to find out where things broke...


date            | tee    /_install_tool_sh_
echo "start"    | tee -a /_install_tool_sh_

# rocky 9/dnf does not have a -t option
# dnf ... did not finish?

dnf -y update 

dnf -y install epel-release
dnf -y install vim
dnf -y install bash

# actually, the perf_tools have tfp* already
# might add config, firewall restrictions...
# so dedicated config may still be best

dnf -y install tftp
dnf -y install tftp-server


date            | tee -a /_install_tool_sh_
echo "end"      | tee -a /_install_tool_sh_


# vim: noexpandtab tabstop=4 paste
