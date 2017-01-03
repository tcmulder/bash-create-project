#!/bin/sh

function make_db(){

	MYSQL=`which mysql`

	Q1="CREATE DATABASE IF NOT EXISTS d1_$the_db;"
	Q2="GRANT USAGE ON *.* TO d1_$the_db_user@localhost IDENTIFIED BY '$the_db_pass';"
	Q3="GRANT ALL PRIVILEGES ON d1_$the_db.* TO d1_$the_db_user@localhost;"
	Q4="FLUSH PRIVILEGES;"

	Q5="CREATE DATABASE IF NOT EXISTS t1_$the_db;"
	Q6="GRANT USAGE ON *.* TO t1_$the_db_user@localhost IDENTIFIED BY '$the_db_pass';"
	Q7="GRANT ALL PRIVILEGES ON t1_$the_db.* TO t1_$the_db_user@localhost;"
	Q8="FLUSH PRIVILEGES;"

	Q9="CREATE DATABASE IF NOT EXISTS s1_$the_db;"
	Q10="GRANT USAGE ON *.* TO s1_$the_db_user@localhost IDENTIFIED BY '$the_db_pass';"
	Q11="GRANT ALL PRIVILEGES ON s1_$the_db.* TO s1_$the_db_user@localhost;"
	Q12="FLUSH PRIVILEGES;"

	SQL="${Q1}${Q2}${Q3}${Q4}${Q5}${Q6}${Q7}${Q8}${Q9}${Q10}${Q11}${Q12}"

	$MYSQL -uadmin -p -e "$SQL"

	echo "I've created the databases d1_$the_db with user d1_$the_db_user and password $the_db_pass"
	echo "I've created the databases t1_$the_db with user t1_$the_db_user and password $the_db_pass"
	echo "I've created the databases s1_$the_db with user s1_$the_db_user and password $the_db_pass"
}