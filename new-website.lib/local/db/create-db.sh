#################################################################
# Create Database
#################################################################

function create_db {

	# set up statements
	MYSQL=`which mysql`

	Q1="CREATE DATABASE IF NOT EXISTS l1_$the_db;"
	SQL="${Q1}"

	# execute statements
	$MYSQL -uroot -p -e "$SQL"

}