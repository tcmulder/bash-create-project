#!/bin/sh

#################################################################
# Import Functions
#################################################################

app_dir="/Applications/MAMP/htdocs/new-website.lib/local"

source "$app_dir"/dir/build-dir.sh
source "$app_dir"/git/hooks/build-hooks.sh
source "$app_dir"/db/create-db.sh
source "$app_dir"/helpers/download-wp.sh
source "$app_dir"/git/init-git.sh
source "$app_dir"/helpers/cp-code.sh
source "$app_dir"/git/clone-repo.sh

#################################################################
# Special Comment Formatting
#################################################################

# format block style echoing
function big_echo(){
	echo
	echo "----------------------------------------"
	echo "//// $1"
	echo "----------------------------------------"
	echo
}

# add space to medium comments
function med_echo(){
	echo
	echo "- $1"
	echo
}

#################################################################
# Gather Project Information
#################################################################

# show messages
big_echo "Building Local Zenpository"
med_echo "Let's start off by getting some information."

# set variables
read -p "What's the client's name? " the_client
read -p "What's the project's name? " the_proj
read -p "What's the unprefixed database name? " the_db

#################################################################
# Establish Directories
#################################################################

# show messages
big_echo "Creating Working Directory"
med_echo "Next we'll set up the working directory."

# set variables
root_dir=`pwd`
loc_dir="/Applications/MAMP/htdocs/sites/"
loc_client=$loc_dir""$the_client"/"
loc_proj=$loc_client""$the_proj"/"

#################################################################
# Creating Site From Remote
#################################################################

# create directories
make_dirs $loc_client $loc_proj

# clone the repository
clone_repo

#################################################################
# Establish Hooks
#################################################################

# show messages
big_echo "Creating Hooks"
med_echo "Let's also set up some hooks."

# create hooks
make_hooks

#################################################################
# Create Database
#################################################################

# show messages
big_echo "Database Setup"
med_echo "A database might be helpful."

# set variables
read -p "Would you also like to create a local database? (y/n) " db_confirm

# create database or don't
if [ $db_confirm == "y" ]; then
	create_db
else
	echo "I won't then."
fi

#################################################################
# Add/Create Code
#################################################################

# show messages
big_echo "Code Setup"
med_echo "I can also add the site's code into the project directory."

# set variables
read -p "Want me to create a new WordPress instance for you? (y/n) " wp_confirm

# download wordpress
if [ $wp_confirm == "y" ]; then
	download_wp

# copy code
elif [ $wp_confirm == "n" ]; then

	# set up variables
	read -p "Want me to import files you downloaded into a different directory? (y/n) " cp_confirm

	# copy code
	if [ $cp_confirm == "y" ]; then
		# get the path
		read -p "What's the path to the directory in which the code is stored? " cp_path
		cp_code $cp_path
	fi

fi

#################################################################
# Initialize Git
#################################################################

# show messages
big_echo "Initialize Git"
med_echo "Let me just do an init commit for git and create some branches."

# initialize git
init_git

#################################################################
# Open Site In Browser
#################################################################

# show messages
big_echo "Open In Browser"
med_echo "I can open this project in your browser (especially useful if you need to to install WordPress)."

read -p "Would you like to open your new project in a browser? (y/n) " open_confirm

if [ $open_confirm == "y" ]; then
	open "http://localhost:8888/sites/$the_client/$the_proj"
fi

#################################################################
# Open Site In Browser
#################################################################

# show messages
big_echo "Local Zenpository Script Completed"

# and they all lived happily ever after
exit