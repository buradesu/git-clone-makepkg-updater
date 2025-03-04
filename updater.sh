#! /bin/bash
echo Starting...

# define colors
GREEN="\e[32m"
MAGENTA="\e[35m"
GREY="\e[90m"
BLUE="\e[36m"
RESET="\e[0m"


# Get the directory of the script
PARENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# move there
cd $PARENT_DIR





# interate over everything in the directory
for directory in *;
do 
	
	echo Trying to enter $directory...

	# try to cd into a directory/file. If fails, skip
	if ! cd "$directory" 2>/dev/null; then
        echo -e "${GREY}Failed to enter $directory, skipping.${RESET}"; echo
        continue
    fi

    # check if the dir is a git repo. If not, skip
	if [[ -d ".git" ]]
	then
	echo "This is a git repository."

	else
	echo -e "${GREY}Not a git repository, skipping${RESET}"; echo
	cd ..
	continue
	fi

	# try to make a git pull
	pullRes=$(git pull 2>&1);
	
	# print the output of git pull
	echo $pullRes

	# if the local vession is newest, git pull returns
	# "Already up to date." - check for that
	if [[ $pullRes == *"Already up to date."* ]]
	then
	echo -e "${GREEN}skipping ${directory}: up to date${RESET}" 
	
	elif [[ $pullRes == *"unable to access"* ]]
	then # if can't access the repo, skip
	echo -e "${GREY}Can't access the repository for pulling, skipping${RESET}"

	# if something was pulled, update and install
	else
	echo -e "${MAGENTA} updating ${directory}...${RESET}"
	makepkg -sic

	# optionally cleanup package files
	read -r -p "Cleanup the package files? (y/n) " answer

	if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "${BLUE}cleanup on ${directory}${RESET}"
	git clean -dfx
	fi
	fi
	


	# print done and exit
	echo Done with $directory; echo
	cd ..;	
done
echo Script has finished.
