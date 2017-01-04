#!/bin/sh

#################################################################
# Make the pre-commit hook
#################################################################

loc_proj=$1

# the pre-commit hook acts like a controller
echo "#!/bin/sh

echo 'Running local pre-commit hook'

bash $loc_proj'.git/hooks/update-db'

git add /Applications/MAMP/htdocs/sites/c/p/.db/*" > $loc_proj"/.git/hooks/pre-commit"

chmod +x $loc_proj".git/hooks/pre-commit"
