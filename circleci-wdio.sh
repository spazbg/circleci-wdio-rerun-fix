#!/bin/bash

platform=$1

case $platform in
  web)
    config="wdio.conf.ts"
    tag="@web"
    ;;
  ios)
    config="wdio.ios.conf.ts"
    tag="@ios"
    ;;
  android)
    config="wdio.android.conf.ts"
    tag="@android"
    ;;
  *)
    echo "Invalid platform. Please choose from 'web', 'ios' or 'android'."
    exit 1
esac

result=""
shift
for spec_uri in "$@"
do
  spec=$(echo $spec_uri | sed -E 's|file://(\./)?||')
  result+="$spec "
done

yarn wdio run $config --cucumberOpts.tags="$tag" --spec $result
