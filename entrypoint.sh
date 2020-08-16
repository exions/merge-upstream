#!/bin/sh -eux

cd "${GITHUB_WORKSPACE}"

git remote add -f upstream "https://github.com/$1.git"
git branch ${GITHUB_REF}
git merge --ff-only upstream/${GITHUB_REF}
git push 
