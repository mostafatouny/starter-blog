#!/bin/sh

currentDate=`date`

git add .
git commit -m "$currentDate"
git push origin master

hugo
cd public

sed -i 's/href="mailto:mostafatouny%3cat%3eproton%3cdot%3eme"/onclick="alert(String.fromCharCode('109','111','115','116','97','102','97','116','111','117','110','121','64','112','114','111','116','111','110','46','109','101'))";/' index.html

git add .
git commit -m "$currentDate"
git push origin master
