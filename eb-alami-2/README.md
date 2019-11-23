The purpose of this article is to supplement the workaround mentioned in https://kumo-knowledge-ui-iad-prod.amazon.com/management/article_5587. Based on the demand for this functionality from customers with time critical compliance requirements on AMI patches, an automated way to perform the procedure on environments with more than one instance was necessary. 

Following are article describes an ebextension, that can be used to modify the default yum configuration to allow for access to the global Amazon linux Yum repo rather than being locked down by guid, which is the default configuration on all Elastic Beanstalk linux AMIs.

Usage:

1) Place the ebextensions YumUpdate.config in your .ebextensions directory in the source bundle

2) Based on whether you want the Yum configuration to be reverted or not, select the following values for the YUM_NO_REVERT variable:

YUM_NO_REVERT = "1"   ========> yum.conf and amzn-updates.repo files will not be reverted back to the locked down versions. 

Not setting YUM_NO_REVERT or setting it to values other than 1 or True, will result in default behavior of reverting modified files to default

3) YUM_COMMAND variable value should be the yum command; example: yum update -y; yum update --security -y .. etc. Include the -y flag to avoid interactive mode and prevent the script from moving forward. 
