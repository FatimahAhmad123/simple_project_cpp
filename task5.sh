#!/bin/bash

# Remote repo
remote_repository="https://github.com/FatimahAhmad123/simple_project_cpp.git"

# Local repo
cd /home/nabeel/Desktop/simple_project_cpp

# Fetch changes in remote repo
git fetch

# All branches in remote repo
remote_branches=$(git ls-remote --heads origin | cut -f 2)


for remote_branch in $remote_branches; do
    
    branch_name="${remote_branch#refs/heads/}" # Extracting branch name

    git checkout $branch_name


    git pull origin $branch_name
	
    # Checking for changes
    if [ $(git rev-parse HEAD) != $(git rev-parse "origin/$branch_name") ]; then


        git add .

        commit_message="Auto-commit at $(date +'%Y-%m-%d %H:%M:%S') on $branch_name"
        git commit -m "$commit_message"

        git push origin $branch_name

        echo "Updated and pushed changes for branch $branch_name."
    else
        echo "No new changes to update for branch $branch_name."
    fi
done
