
# Global variables
BOOK=~/.addressbook
export BOOK

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
    find_lines "$search" | while read i
    do
      echo "$i" | tr ':' '\t'
    done
  fi
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