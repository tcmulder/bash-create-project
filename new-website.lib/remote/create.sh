#!/bin/sh

#################################################################
# Import Functions
#################################################################

app_dir="/Applications/MAMP/htdocs/new-website.lib/remote"

source "$app_dir"/dir/build-dir.sh
source "$app_dir"/git/hooks/build-bare-hooks.sh
source "$app_dir"/git/hooks/build-work-hooks.sh
source "$app_dir"/db/create-db.sh
source "$app_dir"/git/init-git.sh

#################################################################
# Special Comment Formatting
#################################################################

# format block style echoing
function big_echo(){
	echo
	echo "----------------------------------------"
	echo "//// $1"
	echo "----------------------------------------"
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
big_echo "Building Remote Zenpository"
med_echo "Let's start off by getting some information."

# set variables
read -p "What's the client's name? " the_client
read -p "What's the project's name? " the_proj
read -p "What's the unprefixed database name? " the_db
read -p "What's the unprefixed database user? " the_db_user
read -p "What's the database's password? " the_db_pass

#################################################################
# Establish Directories
#################################################################

# show messages
big_echo "Creating Working Directory"
med_echo "Next we'll set up the working directory."

# set variables
git_dir=`pwd`
bare_dir=$git_dir"/"$the_proj.git
echo "the bare repository is: "$git_dir
dev_dir="/var/www/vhosts/new-zenmanblog.com/zen_dev1/sites/"
dev_client=$dev_dir""$the_client"/"
dev_proj=$dev_client""$the_proj"/"
echo "dev project directory is: "$dev_proj
test_dir="/var/www/vhosts/new-zenmanblog.com/zen_test1/sites/"
test_client=$test_dir""$the_client"/"
test_proj=$test_client""$the_proj"/"
echo "test project directory is: "$test_proj
stage_dir="/var/www/vhosts/new-zenmanblog.com/zen_stage1/sites/"
stage_client=$stage_dir""$the_client"/"
stage_proj=$stage_client""$the_proj"/"
echo "stage project directory is is: "$stage_proj

#################################################################
# Create Bare Repo
#################################################################

# show messages
big_echo "Create Bare Repo"
med_echo "Now I'll set up the bare repository"

# big_echo "Bare Repository"
med_echo "Now we'll create the bare repository."
if [ ! -d $the_proj".git" ]; then
	mkdir $the_proj".git"
	echo "Created "$the_proj".git directory"
	cd $the_proj".git"
	git init --bare
	cd -
elif [ -d $the_proj".git" ]; then
	echo "The project directory exists. Exiting."
	exit
else
	echo "Unable to create or cd into directory. Exiting."
	exit
fi

#################################################################
# Create Bare Hooks
#################################################################

# show messages
big_echo "Create Bare Hooks"
med_echo "0000000000000"

med_echo "And now, let's set up some hooks."

rm $bare_dir"/hooks/"*".sample"

# this one is like the controller after a merge
echo "#!/bin/sh

echo
echo 'Running hub post-update hook'
echo

bash hooks/update-branch/update-dev
bash hooks/update-branch/update-test
bash hooks/update-branch/update-stage" > $bare_dir"/hooks/post-update"

chmod +x $bare_dir"/hooks/post-update"

echo "Created hook for post-update"

mkdir $bare_dir"/hooks/update-branch/"

make_bare_hooks "dev"
echo "Created hooks for dev"
make_bare_hooks "test"
echo "Created hooks for test"
make_bare_hooks "stage"
echo "Created hooks for stage"

#################################################################
# Create Working Directories
#################################################################

# show messages
big_echo "Create Working Directories"
med_echo "0000000000000"

big_echo "Creating Working Directories"

med_echo "Next we'll set up the working directories."

make_dirs $dev_client $dev_proj
echo "Created dev instance"
make_dirs $test_client $test_proj
echo "Created test instance"
make_dirs $stage_client $stage_proj
echo "Created stage instance"

med_echo "Let's set up the git config files."
make_work_config $dev_proj
echo "config edited for dev"
make_work_config $test_proj
echo "config edited for test"
make_work_config $stage_proj
echo "config edited for stage"

med_echo "Lastly, let's set up some hooks."
make_work_hooks $dev_proj "d1_" "dev"
echo "dev hooks created"
make_work_hooks $test_proj "t1_" "test"
echo "test hooks created"
make_work_hooks $stage_proj "s1_" "stage"
echo "stage hooks created"

#################################################################
# Create Database
#################################################################

# show messages
big_echo "Create Database"
med_echo "0000000000000"

read -p "Do you want to create a database for this project? (y/n) " db_confirm
if [ $db_confirm == "y" ]; then

	make_db

else
	echo "Great, then we're done."
fi

cd $git_dir

big_echo "Remote Zenpository Script Completed"

exit