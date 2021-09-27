#!/bin/bash

set -e
set -u

SOURCE_DIRECTORY=$1
DESTINATION_GITHUB_USERNAME=$2
DESTINATION_REPOSITORY_NAME=$3
DESTINATION_TARGET_BRANCH=$4
USER_EMAIL=$5
USER_NAME=$6
COMMIT_MESSAGE=$7

if [[ -z $USER_NAME ]]; then
    USER_NAME=$DESTINATION_GITHUB_USERNAME
fi

git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"

if [[ ! -d ~/.ssh ]]; then
    mkdir ~/.ssh
fi

echo "$REPOSITORY_DEPLOY_KEY" > ~/.ssh/id_rsa

cd /temp-workspace/$SOURCE_DIRECTORY

git init

git add .

git status

git diff-index --quiet HEAD || git commit --message "$COMMIT_MESSAGE"

git push "git@github.com:$DESTINATION_GITHUB_USERNAME/$DESTINATION_REPOSITORY_NAME.git" HEAD:"$TARGET_BRANCH"

rm ~/.ssh/id_rsa
