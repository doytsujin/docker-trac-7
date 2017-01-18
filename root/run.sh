#!/bin/bash

#[ -f /.setup_trac.sh ] && /bin/bash /.setup_trac.sh

source /etc/trac/config.sh

tracd $TRAC_ARGS -p $TRAC_PORT  $TRAC_ENV
#tracd $TRAC_ARGS --basic-auth="$TRAC_PROJECT_SHORT,/etc/trac/htpasswd,$COMPANY_NAME" $TRAC_ENV
