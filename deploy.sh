#!/bin/bash

read -p "Do you want to optimize style.css? (y/n) " -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# clean the css
	# cleancss static/css/style.css | gsed 's/\/\*!/\n&/g' | gsed 1d > static/css/style.min.css
	./cleancss
fi

echo -e "\033[0;32mDeploying goose.us updates...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# run git status to check files being updated
git status

read -p "Do you want to deploy these changes? (y/n) " -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# Add changes to git.
	git add .

	# Commit changes.
	msg="rebuilding site `date`"
	if [ $# -eq 1 ]
	  then msg="$1"
	fi
	git commit -m "$msg"

	# Push source and build repos.
	git push origin master
fi

# Come Back up to the Project Root
cd ..

