Using two-factor auth, we can set environment variables to make flow better

make a file ex.  gitcred.sh
# Initiate Variable is same file or another place, .bashrc prob bad

#!/bin/bash
GIT_USERNAME='gitusername'
GIT_PASSWORD='THETOCKEN'

echo username=$GIT_USERNAME
echo password=$GIT_PASSWORD


now in term set

git config credential.helper "/bin/bash ~/gitcred.sh"


