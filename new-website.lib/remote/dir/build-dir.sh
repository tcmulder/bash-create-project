#!/bin/sh

function make_dirs(){
	if [ ! -d $1 ]; then
		mkdir $1
		echo "Created directory "$1
		cd $1
	elif [ -d $1 ]; then
		echo "Using existing client directory"
		cd $1
	else
		echo "Unable to create or cd into directory. Exiting."
		cd $git_dir
		exit
	fi

	if [ ! -d $2 ]; then
		mkdir $2
		echo "Created directory "$2
		cd $2
		git init
		echo "deny from all" > .git/.htaccess
		if [ ! -d ../archive/ ]; then
			mkdir ../archive/
		fi
		if [ ! -f ../index.php ]; then
			cp /var/www/vhosts/new-zenmanblog.com/zen_dev1/sites/client_template/* ../
		fi
	elif [ -d $2 ]; then
		echo "The project directory exists. Exiting."
		cd $git_dir
		exit
	else
		echo "Unable to create or cd into directory. Exiting."
		cd $git_dir
		exit
	fi

	cd $git_dir
}