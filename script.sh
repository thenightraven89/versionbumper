#!/bin/sh
### Increments the part of the string
## $1: version itself
## $2: number of part: 0 – major, 1 – minor, 2 – patch
increment_version() {
  local branchSource="main"
  local branchBumpMinor="testing"
  local branchBumpMajor="production"
  local delimiter=.
  local versionfile=`cat ./version.txt`
  local branch=($(git rev-parse --abbrev-ref HEAD))
  local array=($(echo "$versionfile" | tr $delimiter '\n'))

  for index in ${!array[@]}; do
    if [ $index -eq $1 ]; then
      local value=array[$index]
      value=$((value+1))
      array[$index]=$value
      break
    fi
  done

  echo $(IFS=$delimiter ; echo "${array[*]}") > ./version.txt
  if [ "$branch" == "$branchSource" ]; then
	  echo "yay"
  else
	  echo "nay"
  fi
}

increment_version $1
