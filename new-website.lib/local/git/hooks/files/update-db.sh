#!/bin/sh

#################################################################
# Make the update-db file
#################################################################

loc_proj=$1
the_db=$2

# hook to update the db
echo "#!/bin/sh

echo 'The database update script will now run.'

# figure out the branch and use that for the db update
branch=\$(git symbolic-ref -q HEAD)
branch=\${branch##refs/heads/}
branch=\${branch:-HEAD}
echo \"On branch \$branch\"

if [ \"\$branch\" == 'dev' ]; then
	str_repl='dev1.zenman.com'
elif [ \"\$branch\" == 'test' ]; then
	str_repl='test1.zenman.com'
elif [ \"\$branch\" == 'stage' ]; then
	str_repl='stage1.zenman.com'
fi


if [ \$str_repl ]; then

	# update the git_dump db
	php -f /Applications/MAMP/htdocs/_far.php 'localhost' 'root' 'root' 'l1_p' 'localhost:8888' \"\$str_repl\"

	# dump the original db as _db.sql
	/Applications/MAMP/Library/bin/mysqldump --opt -hlocalhost -uroot -proot l1_$the_db > "$loc_proj".db/\"\$branch\"_db.sql

	# update the git_dump db
	php -f /Applications/MAMP/htdocs/_far.php 'localhost' 'root' 'root' 'l1_p' \"\$str_repl\" 'localhost:8888'

else
	echo 'The database for this branch does not update.'
fi" > $loc_proj"/.git/hooks/update-db"

chmod +x $loc_proj".git/hooks/update-db"