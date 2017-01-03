#################################################################
# Controller for Hook Creation
#################################################################

function make_hooks(){

	# remove all the sample hooks
	rm $loc_proj".git/hooks/"*".sample"

	# execute all scripts and pass in local project variable
	for f in $app_dir/git/hooks/files/*
	do
		sh $f $loc_proj $the_db
	done
}