#!/bin/bash
export TRAC_ENV=/var/trac
export TRAC_PROJECT_NAME="My Project"
export TRAC_PROJECT_SHORT=myproject



export GIT_USER_NAME="Trac Admin"
export GIT_USER_EMAIL=trac@localhost
 
# Make sure $TRAC_ENV is empty when try trac-admin $TRAC_ENV initenv 
# so don't put GIT_REPOSITORY under TRAC_ENV
export GIT_REPOSITORY=/var/git/$TRAC_PROJECT_SHORT.git
export GIT_ROOT=`dirname $GIT_REPOSITORY`


