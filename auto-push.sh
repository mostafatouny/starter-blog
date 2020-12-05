#!/bin/sh

currentDate=`date`

git add .
git commit -m "$currentDate"
git push origin master

hugo
cd public

git add .
git commit -m "$currentDate"
git push origin master

#pass: same as qnb e-wallet
