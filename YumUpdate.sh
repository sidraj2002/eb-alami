#!/bin/bash
set -xe
    #FilesNames#
    _YumConfFile='yum.conf'
    _YumRepoFile='amzn-updates.repo'

    #SourceFilePaths#
    _YumRepoFilePath='/home/ec2-user/Replace/tmp/'
    _YumConfFilePath='/home/ec2-user/Replace/tmp/'
    #_DefaultYumConfFile='/etc/yum.conf'
    #_DefaultYumRepoFile='/etc/yum.repos.d/amzn-updates.repo'

    #OriginalFilePaths#
    _DefaultYumConfFilePath='/home/ec2-user/Replace/etc/'
    _DefaultYumRepoFilePath='/home/ec2-user/Replace/etc/yum.repos.d/'

    #StagingFilePaths#
    _StagingYumConfFilePath='/home/ec2-user/Replace/Staging/'
    _StagingYumRepoFilePath='/home/ec2-user/Replace/Staging/'

    #Revert Setting
    _YUM_DONT_REVERT=$(/opt/elasticbeanstalk/bin/get-config environment -k YUM_DONT_REVERT);

function ReplaceFile (){
    echo "Source file is ${1}${3}"
    echo "Target File is ${2}${3}"
    cp -f ${2}${3} ${4}${3}
    rm -rf ${2}${3}
    cp -f ${1}${3} ${2}${3}
    echo "Staging ${4}${3}"
    echo "Target ${2}${3}"

    #Revert Back

    if [ "$_YUM_DONT_REVERT" -eq "True" ] || [ "$_YUM_DONT_REVERT" -eq "1" ]
    then
    echo "Revert file to original: FALSE"
    else
    echo "Revert file to original: TRUE"
    rm -rf ${2}${3}
    cp -f ${4}${3} ${2}${3}
    fi;
    };


   _YumConfFileBak=$(ReplaceFile $_YumConfFilePath  $_DefaultYumConfFilePath $_YumConfFile $_StagingYumConfFilePath);
   echo $YumConfFileBak
