#################################################################
# Download WordPress
#################################################################

function download_wp(){

	# get the version
	read -p "What version? Either type latest or a version number like 3.4.2 now: " wp_version

	# download the latest
	if [ $wp_version == "latest" ]; then
		wget -O $loc_proj/wordpress.tar.gz http://wordpress.org/latest.tar.gz

	# download an older version
	else
		wget -O $loc_proj/wordpress.tar.gz http://wordpress.org/wordpress-$wp_version.tar.gz
	fi

	# unzip and move contents into root
	tar -zxf $loc_proj/wordpress.tar.gz --directory $loc_proj
	mv $loc_proj/wordpress/* $loc_proj

	# clean up download files
	rm -f $loc_proj/wordpress.tar.gz
	rmdir $loc_proj/wordpress/

}