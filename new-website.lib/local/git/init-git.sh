#################################################################
# Initialize Repository
#################################################################

function init_git(){

	#cd into the project
	cd $loc_proj

	# make a private database folder
	mkdir $loc_proj.db
	echo "deny from all" > $loc_proj.db/.htaccess

	# create .git* files
	echo "* -text" > .gitattributes
	echo ".DT_Store
	sitemap.xml
	sitemap.xml.gz
	# Ignore sass-cache files.
	*.sass-cache*" > .gitignore

	# do an initial commit
	git add .
	git commit -m "init"

	# create branches and checkout dev
	git branch dev
	git branch test
	git branch stage
	git checkout dev

	# output the status (for debug)
	git status
}