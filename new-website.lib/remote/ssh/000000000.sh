#!/bin/sh

#################################################################
# Import Functions
#################################################################

hostname='tcmulder@tcmulder.com'
filename='~/temp/test1.sh'

if [ -n "`ssh $hostname \"test -f $filename && echo exists\"`" ]
then
     echo 'Running up-to-date script.'
else
     echo 'Uploading up-to-date script to run.'
     cat test1.sh | ssh tcmulder.com 'cd ~/temp; cat - > test1.sh'
fi

ssh -t tcmulder@tcmulder.com 'cd ~/temp ; bash test1.sh ; exit'

echo "Remote scripts completed."