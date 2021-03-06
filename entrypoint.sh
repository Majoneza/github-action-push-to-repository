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

if [ -z $USER_NAME ]; then
    USER_NAME=$DESTINATION_GITHUB_USERNAME
fi

git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

echo "$REPOSITORY_DEPLOY_KEY" > ~/.ssh/id_github_token

chmod 600 ~/.ssh/id_github_token

cd /github/workspace

if [ -e ./.git ]; then
    rm -rf ./.git
fi

if [ -e ./.github ]; then
    rm -rf ./.github
fi

if [ -e ./.gitignore ]; then
    rm ./.gitignore
fi

git init

git config core.sshCommand "ssh -oStrictHostKeyChecking=no -i ~/.ssh/id_github_token"

git add -A

git status

git commit -a --allow-empty-message --message "$COMMIT_MESSAGE"

git push --force "git@github.com:$DESTINATION_GITHUB_USERNAME/$DESTINATION_REPOSITORY_NAME.git" HEAD:"$DESTINATION_TARGET_BRANCH"

rm ~/.ssh/id_github_token
