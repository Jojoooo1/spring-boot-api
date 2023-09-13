#!/bin/bash
set -e # exit on first error (used for return

message() {
  echo -e "\n######################################################################"
  echo "# $1"
  echo "######################################################################"
}

LATEST_TAG=$(git describe --tags "$(git rev-list --tags --max-count=1)") # gets tags across all branches, not just the current branch

message ">>> Starting PR"

[[ ! -x "$(command -v gh)" ]] && echo "gh not found, you need to install github CLI" && exit 1

gh auth status

# 1. Make sure branch is set to develop
[[ $(git rev-parse --abbrev-ref HEAD) != "develop" ]] && echo "ERROR: Checkout to develop" && exit 1

# 2. Make sure branch is clean
[[ $(git status --porcelain) ]] && echo "ERROR: The branch is not clean, commit your changes before creating the release" && exit 1

message ">>> Pulling develop"
git pull origin develop

BRANCH_NAME="merge/$LATEST_TAG"

git checkout -b $BRANCH_NAME develop
git pull origin main
git push origin "$BRANCH_NAME"

gh pr create --base develop --head "$BRANCH_NAME" --title "Merge into develop $LATEST_TAG" --fill

