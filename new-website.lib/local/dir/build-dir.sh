#################################################################
# Make Client/Project Directories
#################################################################

function make_dirs(){

	# if the client directory doesn't exist create it
	if [ ! -d $1 ]; then
		mkdir $1
		echo "Created directory "$1

	# if the client directory does exist then explain
	elif [ -d $1 ]; then
		echo "Using existing client directory"
	fi
}