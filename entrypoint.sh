#!/bin/sh -eux

cd "${GITHUB_WORKSPACE}"

git remote add -f upstream "https://github.com/$1.git"
git merge --ff-only upstream/$2
git push 
