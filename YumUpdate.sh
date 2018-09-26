#!/bin/bash
set -xe

    _YumConfFile='yum.conf'
    _YumRepoFile='amzn-updates.repo'
    _YumUpdateRepoFilePath='home/ec2-user/Replace/tmp/'
    _YumConfFilePath='home/ec2-user/Replace/tmp/'
    #_DefaultYumConfFile='/etc/yum.conf'
    #_DefaultYumRepoFile='/etc/yum.repos.d/amzn-updates.repo'
    _DefaultYumConfFilePath='/home/ec2-user/Replace/etc/'
    _DefaultYumRepoFilePath='/home/ec2-user/Replace/etc/yum.repos.d/'

    _StagingYumConfFilePath='/home/ec2-user/Replace/tmp/yum_staging/'
    _StagingYumRepoFilePath='/home/ec2-user/Replace/tmp/yum_staging/'


function ReplaceFile (){
    echo "Source file is ${1}${3}"
    echo "Target File is ${2}${3}"
    mv ${2}${3} /tmp/${3}.bak
    cp -f ${1}${3} ${2}${3}
    echo "/tmp/${3}.bak"
   }
echo "ReplaceFile"
_YumConfFileBak=$(ReplaceFile() $_YumConfFilePath $_DefaultYumConfFilePath $_YumConfFile)
echo $_YumConfFileBaky
