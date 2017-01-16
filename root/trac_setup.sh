#!/bin/bash
source /etc/trac/config.sh


setup_trac() {
    [ ! -d $TRAC_ENV ] && mkdir $TRAC_ENV
    if [ ! -f $TRAC_ENV/VERSION ]
    then
        #trac-admin $TRAC_ENV initenv "$TRAC_PROJECT_NAME" sqlite:db/trac.db git $GIT_REPOSITORY
        trac-admin $TRAC_ENV initenv "$TRAC_PROJECT_NAME" sqlite:db/trac.db
		
		#setup_components
        #setup_accountmanager
        #setup_admin_user
	#setup_git
        #trac-admin $TRAC_ENV config set logging log_type stderr
        [ -f /var/www/trac_logo.png ] && cp -v /var/www/trac_logo.png $TRAC_ENV/htdocs/trac_logo.png
    fi
}

create_repo() {
	echo "Checking GIT Repository for $GIT_REPOSITORY"
    [ ! -d $GIT_ROOT ] && mkdir -p $GIT_ROOT
	
    if [ ! -d $GIT_REPOSITORY ]
    then
		echo "Setting GIT Repository for $GIT_REPOSITORY"
		# GIT global config
        git config --global user.name "$GIT_USER_NAME"
		git config --global user.email "$GIT_USER_EMAIL"
		
        # Create GIT Repo
		mkdir $GIT_REPOSITORY
		pushd $GIT_REPOSITORY
		    git init --bare
        popd

        # Make a 1st commit
		echo "Making 1st commit ..."
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
#clean_house
