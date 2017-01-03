#!/bin/sh

function make_work_hooks(){
	rm $1".git/hooks/"*".sample"
	echo "#!/bin/sh

echo
echo '**** Updating Database'
echo

if [ -f .db/$3_db.sql ]; then
	mysqldump -hlocalhost -u$2$the_db_user -p$the_db_pass --no-data $2$the_db | grep ^DROP > .db/drop.sql
	mysql -hlocalhost -u$2$the_db_user -p$the_db_pass $2$the_db < .db/drop.sql
	mysql -hlocalhost -u$2$the_db_user -p$the_db_pass $2$the_db < .db/$3_db.sql
	rm .db/drop.sql
else
	echo 'No database update found'
fi" > $1".git/hooks/post-merge"

	chmod +x $1".git/hooks/post-merge"

}