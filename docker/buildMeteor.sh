#!/bin/bash
rm -rf meteor/bundle nginx/bundle
cd ../app
meteor build --architecture os.linux.x86_64 --directory ../docker/meteor
cd -
cp -R meteor/bundle nginx
