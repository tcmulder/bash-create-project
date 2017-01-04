#!/bin/sh

function make_bare_hooks(){
	touch $bare_dir"/hooks/update-branch/update-"$1

	echo "#!/bin/sh

	echo
	echo '------------------------------'
	echo '//// Updating $1'
	echo '------------------------------'
	echo

	cd /var/www/vhosts/new-zenmanblog.com/zen_"$1"1/sites/$the_client/$the_proj || exit
	unset GIT_DIR
	git pull hub $1

	exec git-update-server-info" > $bare_dir"/hooks/update-branch/update-$1"

	chmod +x $bare_dir"/hooks/update-branch/update-"$1
}