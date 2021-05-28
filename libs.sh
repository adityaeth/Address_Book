
# Global variables
BOOK=~/.addressbook
export BOOK

confirm() {
  echo -en "$@"
  read ans
  ans=`echo $ans | tr '[a-z]' '[A-Z]'`
  if [ "$ans" == "Y" ]; then
    return 0
  else
    return 1
  fi
}

find_lines() {
  res=-1
  if [ ! -z "$1" ]; then
  grep -i "$@" $BOOK
  res=$?
  fi
  return $res
}

num_lines()
{
  grep -i "$@" $BOOK | wc -l
}

list_items() {
  if [ "$#" -eq "0" ]; then
    echo -en "Search for: ( blank to list all )"
    read search
    if [ -z "$search" ]; then
      search="."
    fi
    echo
  else
    search="$@"
    fi
    find_lines "$search" | while read i
    do
      echo "$i" | tr ':' '\t'
    done
  echo
  echo -en "Matches found: "
  num_lines "$search"
}

add_item() {
  echo
  echo "Adding Details..."
  echo 
  echo -en "Name: "
  read name
  find_lines "${name}:"
  if [ `num_lines "${name}:"` -ne "0" ]; then
    echo "$name already exist."
    return
  fi
  echo -en "Phone: "
  read phone
  echo -en "email: "
  read email

  echo "${name}:${phone}:${email}" >> $BOOK
  }

locate_single_item(){
  echo -en "Enter search keyword: "
  read search
  n=`num_lines "$search"`
  if [ -z "$n" ]; then
    n=0
  fi
  if [ "${n}" -ne "1" ]; then
    echo "${n} matches found. Only one allowed. Try again."
  fi
  echo "Specific search term? ( q=exit): "
  read search
  if [ "$search" == "q" ]; then
    return 0
  fi
  n=`num_lines "$search"`
  return `grep -i $search $BOOK | cut -d ":" -f1`
}

edit_item(){
  locate_single_item
  search=`head -$? $BOOK`
  if [ -z "${search}" ]; then
	return
  fi
  list_items "$search"
}

remove_item() {
  locate_single_item
  search=`head -$? $BOOK`
  if [ -z "${search}" ]; then
    return
  fi
  list_items "$search"
  confirm -en "Remove? y/n"
  if [ "$?" -eq "0" ]; then
  grep -v "$search" $BOOK > ${BOOK}.tmp ; mv ${BOOK}.tmp ${BOOK}
  else
  echo "Aborting"
  fi
}