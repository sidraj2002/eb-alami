#!/bin/bash
set -xe

    #Script currently replaces original file with modded file, then based on YUM_NO_REVERT variable will either.. 
    #revert back to original or keep modded config. Default = revert).

    #FilesNames#
    _YumConfFile='yum.conf'
    _YumRepoFile='amzn-updates.repo'

    #SourceFilePaths#
    _YumRepoFilePath='/home/ec2-user/Replace/tmp/yum.repos.d/'
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
    _YUM_DONT_REVERT=$(/opt/elasticbeanstalk/bin/get-config environment -k YUM_NO_REVERT);
    _YumCommand=$(/opt/elasticbeanstalk/bin/get-config environment -k YUM_COMMAND);


function ReplaceFile (){
    echo "Source file is ${1}${3}"
    echo "Target File is ${2}${3}"
    cp -f ${2}${3} ${4}${3}
    rm -rf ${2}${3}
    cp -f ${1}${3} ${2}${3}
    echo "Staging ${4}${3}"
    echo "Target ${2}${3}"
    };

    #Revert Back
function RevertFile (){
    echo "Begin Revert"
    echo ${2}${3}
    echo ${4}${3}
    if [ "$_YUM_DONT_REVERT" -eq "True" ] || [ "$_YUM_DONT_REVERT" -eq "1" ]
    then
    echo "Revert file to original: FALSE"
    else
    echo "Revert file to original: TRUE"
    rm -rf ${2}${3}
    cp -f ${4}${3} ${2}${3}
    fi;
    };


    ReplaceFile $_YumConfFilePath  $_DefaultYumConfFilePath $_YumConfFile $_StagingYumConfFilePath;
    echo $YumConfFileBak
    ReplaceFile $_YumRepoFilePath $_DefaultYumRepoFilePath $_YumRepoFile $_StagingYumRepoFilePath;

    #Run Yum (Separate function of the above #Revert Back)
    yum clean all;
    echo $_YumCommand;
    #Revert Back

    RevertFile $_YumConfFilePath  $_DefaultYumConfFilePath $_YumConfFile $_StagingYumConfFilePath;
    RevertFile $_YumRepoFilePath $_DefaultYumRepoFilePath $_YumRepoFile $_StagingYumRepoFilePath;
