#!/bin/sh

cp -r 00-template $1
sed -i 's/<TEMPLATE>/'$1/ $1/Makefile
