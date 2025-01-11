#!/usr/bin/env bash

logosRootPath=${1:-$PWD}
defaultGroup=${2:-AT}
targetStyle=${3:-default}
extensionPreference=${4:-'svg/webp/png/jpg/ico'}

cd $logosRootPath
find . -type l -delete
for groupFolder in $(ls -d */); do
  cd "$groupFolder"
  for logoStyleVariant in $(find . -type f | sed 's#.*/##; s#[.][^.]*$##' | sort | uniq); do
    for extension in $(echo $extensionPreference | tr "/" "\n"); do
      if [ -f $logoStyleVariant.$extension ]; then
        ln -s -F -f $logoStyleVariant.$extension $logoStyleVariant
        break
      fi
    done
  done
  for logoVariant in ${targetStyle}_*; do
    ln -s -F -f $logoVariant logo_${logoVariant/#`echo $targetStyle`_/}
  done
  cd ..
done

ln -s -F -f $defaultGroup/* ./
