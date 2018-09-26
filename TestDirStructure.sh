#!/bin/bash

Replace=/home/ec2-user/Replace
Source=/home/ec2-user/Replace/tmp
Etc=/home/ec2-user/Replace/etc
Staging=/home/ec2-user/Replace/Staging

if [ -d "$Replace" ]; then
 echo "Replace Dir exists"
 rm -rf $Replace
fi

mkdir $Replace
mkdir $Source
mkdir $Staging
mkdir $Etc
mkdir "$Etc/yum.repos.d"
mkdir "$Source/yum.repos.d"

echo "Modded Yum" > "$Source/yum.conf"
echo "Modded Repo" > "$Source/yum.repos.d/amzn-updates.repo"
echo "Orignal Yum" > "$Etc/yum.conf"
echo "Original Repo" > "$Etc/yum.repos.d/amzn-updates.repo"
