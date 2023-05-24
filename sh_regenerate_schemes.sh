#!/bin/bash

dirList=(".")

BLUE='\033[0;34m'
ORANGE='\033[0;33m'
NONCOLOR='\033[0m'

if [[ -n $1 ]]; then
  dirList=("$1")
else
  echo -e "No dir was provided. Will build all ${#dirList[@]} directories."
fi
echo "Star building for folders:"
for ((i = 0; i < ${#dirList[@]}; i++)); do
  echo "$((i + 1))) ${dirList[i]}"
done

for ((i = 0; i < ${#dirList[@]}; i++)); do
  cd "${dirList[$i]}" || exit
  echo "${ORANGE}=======>   ${BLUE}PUB GET IN ${ORANGE}${dirList[$i]}${NONCOLOR}"
  flutter clean
  flutter pub get
  flutter packages pub get
  echo "${ORANGE}=======>   ${BLUE}GENERATE IN ${ORANGE}${dirList[$i]} 🔨🔨🔨${NONCOLOR}"
  flutter packages pub run build_runner build --delete-conflicting-outputs
  cd ..
done
