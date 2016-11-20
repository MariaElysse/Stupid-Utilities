#!/bin/bash
LOG_FILE='/var/log/EasyDeploy.log'
REPOS_FILE="$1"
function usage {
    echo "Usage: $0 GIT_REPO_FILE"
    echo "With GIT_REPO_FILE containing a (bash-style) list of repository directories"
    echo "to scan."
    echo "It's assumed that the origin is set and the correct branch is checked out."
    exit -1
}

if [[ $REPOS_FILE = "" ]]; then
    echo "ERROR: No file containing repositories to update was given."
    usage
fi

if [[ ! -f $REPOS_FILE ]]; then
    echo "ERROR: \"$REPOS_FILE\" is not a regular file or does not exist."
    usage
fi 

if [[ ! -r $REPOS_FILE ]]; then 
    echo "ERROR: \"$REPOS_FILE\" is not readable (you may want to run as root)"
    usage
fi     


function needs_update {
    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
        echo "Up-to-date"
        return 1
    elif [ $LOCAL = $BASE ]; then
        echo "Need to pull"
        return 0
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push. This should not happen as you should not commit from here"
        return -1
    else
        echo "Diverged. This should not happen as you should not commit from here"
        return -1
    fi
}
let failed_pulls=0
while true 
do 
    while read -r repo  || [[ -n "$repo" ]] 
    do
        cd "$repo"
        owner="$(stat -c %U .git/)"
        if [[ $? -ne 0 ]]; then
            echo "Folder is not a git repository"
        else 
            sudo -u "$owner" "git" "remote" "update" 
            git_status="$(git status)"
            update=needs_update
            if [[ update -eq 0 ]]; then
                echo "$repo:"
                sudo -u "$owner" "git" "pull"
                if [[ ! $? ]]; then
                    echo "git-pull failed"
                    if [[ $failed_pulls -gt 5 ]]; then
                        echo "FATAL: 5 Failed pulls in repository" "$dir"
                        exit -1
                    fi
                    let failed_pulls=$failed_pulls+1
                fi
            elif [[ update -eq -1 ]]; then 
                echo "Problem with git repository. Exiting."
                exit -1
            else
                sleep 1s
            fi
        fi
    done < "$REPOS_FILE"
    sleep 30s
        
done

