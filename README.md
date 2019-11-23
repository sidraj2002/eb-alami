By default the yum repos are configured to be locked to a specific Guid. This will prevent the kernel from being updated using "$ yum update kernel". The expected behavior in this case would be the following: 

yum update kernel 
Loaded plugins: priorities, update-motd, upgrade-helper 
amzn-main | 2.1 kB 00:00:00 
amzn-updates | 2.5 kB 00:00:00 
No packages marked for update 

The recommended way to handle kernel updates for Beanstalk is to wait on the Beanstalk team to release an update. However, if the customer is not willing to wait and wants to update the kernel manually (like on a standard Amazon linux AMI) or wants to install security update normally available on EC2 Amazon linux but not yet available on Beanstalk, they can follow the steps below (please let customers know to try this at their own risk): 

Short summary of steps:

1) Modify /etc/yum.repos.d/amzn-updates.repo and /etc/yum.conf

2) Update kernel or install security updates

3) Reboot instance

4) Revert /etc/yum.repos.d/amzn-updates.repo and /etc/yum.conf to original

Commands used:

1) Modify /etc/yum.repos.d/amzn-updates.repo and /etc/yum.conf: 

Update the following line in the file /etc/yum.repos.d/amzn-updates.repo in the [amzn-updates] section

mirrorlist=http://repo.$awsregion.$awsdomain/$releasever/updates/mirror.list-$guid ==> mirrorlist=http://repo.$awsregion.$awsdomain/$releasever/updates/mirror.list


Update the following line in the file /etc/yum.conf:

releasever=2017.09 ==> releasever=latest

2) Run:

$ yum clean all 

$ yum update kernel  ... OR ... $ yum update --security  (if only security updates need to be installed)

3) Reboot the instance and check if the kernel was updated using $ uname -r

4) Revert changes made to /etc/yum.repos.d/amzn-updates.repo



The above process was tested with before and after deployments for stability on the following platform, please test on other platforms before forwarding to the customer:

64bit Amazon Linux 2017.09 v2.6.1 running Python 3.4



As an additional note, you will notice that configuration file has quite a few variables, to view their values I found the following command to be useful: 

$ python -c 'import yum, pprint; yb = yum.YumBase(); pprint.pprint(yb.conf.yumvar, width=1)



Adding a prototype ebextensions, which can do in-line swap for the guid lock and revert it back. Please test this on your own environments before sending out to customers as this is not fully tested on all platforms. *Be sure to indicate this is not for prod use and has risks involved in doing so*
