#!/bin/bash
source /etc/trac/config.sh


setup_trac() {
    [ ! -d $TRAC_ENV ] && mkdir $TRAC_ENV
    if [ ! -f $TRAC_ENV/VERSION ]
    then
        #trac-admin $TRAC_ENV initenv "$TRAC_PROJECT_NAME" sqlite:db/trac.db git $GIT_REPOSITORY
        trac-admin $TRAC_ENV initenv "$TRAC_PROJECT_NAME" sqlite:db/trac.db
		
	trac-admin $TRAC_ENV session add admin admin root@localhost
	trac-admin $TRAC_ENV permission add admin TRAC_ADMIN
		
        # from https://trac-hacks.org/wiki/AccountManagerPlugin/AuthStores
	# using HtDigestStore
	# be sure to enable the component
    #trac-admin $TRAC_ENV config set components acct_mgr.htfile.HtDigestStore enabled
	
	trac-admin $TRAC_ENV config set components acct_mgr.admin.* enabled
    trac-admin $TRAC_ENV config set components acct_mgr.api.* enabled
	trac-admin $TRAC_ENV config set components acct_mgr.db.sessionstore disabled
    trac-admin $TRAC_ENV config set components acct_mgr.htfile.HtDigestStore disabled
    trac-admin $TRAC_ENV config set components acct_mgr.htfile.HtPasswdStore enabled
    trac-admin $TRAC_ENV config set components acct_mgr.http.* disabled
    trac-admin $TRAC_ENV config set components acct_mgr.web_ui.* enabled
    trac-admin $TRAC_ENV config set components acct_mgr.register disabled
    trac-admin $TRAC_ENV config set components acct_mgr.web_ui.resetpwstore disabled	
    trac-admin $TRAC_ENV config set components acct_mgr.pwhash.* disabled
    trac-admin $TRAC_ENV config set components acct_mgr.pwhash.htdigesthashmethod enabled
	
	# configure the plugin to store passwords in the htdigest format
	#trac-admin $TRAC_ENV config set account-manager password_store HtDigestStore
	trac-admin $TRAC_ENV config set account-manager password_store HtPasswdStore
    trac-admin $TRAC_ENV config set account-manager htpasswd_hash_type md5
	
	# the webserver will need write permissions to this file and its parent folder
	#trac-admin $TRAC_ENV config set account-manager htdigest_file /etc/trac/htdigest
	trac-admin $TRAC_ENV config set account-manager htpasswd_file  /etc/trac/htpasswd
	
	# the name of the authentication "realm", it can be any text to identify your site or project
	#trac-admin $TRAC_ENV config set account-manager htdigest_realm TracRealm

	trac-admin $TRAC_ENV config set account-manager login_attempt_max_count 3
	trac-admin $TRAC_ENV config set account-manager user_lock_time 10
	trac-admin $TRAC_ENV config set account-manager user_lock_max_time 0
	trac-admin $TRAC_ENV config set account-manager user_lock_time_progression 2
	
	# Logo
	[ -f $PROJECT_LOGO ] && cp -v $PROJECT_LOGO $TRAC_ENV/htdocs/
	trac-admin $TRAC_ENV config set header_logo alt "$TRAC_PROJECT_NAME logo"
	trac-admin $TRAC_ENV config set header_logo src site/`basename $PROJECT_LOGO`
	trac-admin $TRAC_ENV config set header_logo width 64
	trac-admin $TRAC_ENV upgrade
	
	# MasterTicketsPlugin
	trac-admin $TRAC_ENV config set ticket-custom blocking text
	trac-admin $TRAC_ENV config set ticket-custom blocking.label "Blocking"
	trac-admin $TRAC_ENV config set ticket-custom blockedby text
	trac-admin $TRAC_ENV config set ticket-custom blockedby.label "Blocked By"
    trac-admin $TRAC_ENV config set components mastertickets.* enabled
	trac-admin $TRAC_ENV upgrade
	
	# Graphviz
    trac-admin $TRAC_ENV config set components graphviz.* enabled
	
	# WikiAutoComplete
    trac-admin $TRAC_ENV config set components wikiautocomplete.web_ui.* enabled
	
	# TracTags
    trac-admin $TRAC_ENV config set components tractags.* enabled
	trac-admin $TRAC_ENV upgrade
	
	# CardsPlugin
	# https://trac-hacks.org/wiki/CardsPlugin
    trac-admin $TRAC_ENV config set components cards.* enabled
	trac-admin $TRAC_ENV config set cards auto_refresh True
	trac-admin $TRAC_ENV config set cards auto_refresh_interval 10
	trac-admin $TRAC_ENV upgrade
	
	# TracStatsPlugin
	# https://trac-hacks.org/wiki/TracStatsPlugin
    trac-admin $TRAC_ENV config set components tracstats.* enabled
	trac-admin $TRAC_ENV config set git cached_repository True
	trac-admin $TRAC_ENV config set git persistent_cache True
	
	# IncludeMacro
	# https://trac-hacks.org/wiki/IncludeMacro
    trac-admin $TRAC_ENV config set components includemacro.* enabled
	
    #trac-admin $TRAC_ENV config set logging log_type stderr
        
    fi
}

create_repo() {
	echo ">> Checking GIT Repository for $GIT_REPOSITORY"
    [ ! -d $GIT_ROOT ] && mkdir -p $GIT_ROOT
	
    if [ ! -d $GIT_REPOSITORY ]
    then
		echo ">> Setting GIT Repository for $GIT_REPOSITORY"
		# GIT global config
        git config --global user.name "$GIT_USER_NAME"
		git config --global user.email "$GIT_USER_EMAIL"
		
        # Create GIT Repo
		mkdir $GIT_REPOSITORY
		pushd $GIT_REPOSITORY
		    git init --bare
        popd

        # Make a 1st commit
		echo ">> Making 1st commit ..."
		pushd /tmp
            git clone $GIT_REPOSITORY repo
            pushd repo
                echo "Welcome to $TRAC_PROJECT_NAME" > README
                git add README
                git commit README -m "initial commit"
                git push origin master
            popd
            rm -rf repo
        popd
    fi
}

setup_repo() {
    trac-admin $TRAC_ENV config set components tracopt.versioncontrol.git.* enabled 
    trac-admin $TRAC_ENV config set repositories .type git 
    trac-admin $TRAC_ENV config set repositories .dir $GIT_REPOSITORY
	
	#agp: GitHub: trac-admin /trac config set components tracext.git.* enabled 
    #agp: Giolite: trac-admin /trac config set components trac_gitolite.* enabled
	# agp
	
    
}

setup_apache() {
	echo ">> Adding $TRAC_ENV to apache server"
	sed -i "s#{TRAC_ENV}#$TRAC_ENV#g" /etc/apache2/conf-available/trac.conf 
}


setup_plugings() {
	echo ">> Setting up Plugins"
	
	trac-admin $TRAC_ENV config set components tracwysiwyg.* enabled
	#trac-admin $TRAC_ENV config set components graphviz.* enabled
	#trac-admin $TRAC_ENV config set components wikiautocomplete.web_ui.wikiautocompletemodule.* enabled
	
}


clean_house() {
    if [ -d /.setup_trac.sh ] && [ -d /.setup_trac_config.sh ]
    then
        rm -v /.setup_trac.sh
        rm -v /.setup_trac_config.sh
    fi
}

setup_trac
create_repo
setup_repo
setup_plugings

#setup_apache

#clean_house
