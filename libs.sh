
# Global variables
BOOK=.addressbook
export BOOK

find_lines() {
  res=-1
  if [ ! -z "$1"]; then
  grep -i "$@" $BOOK
  res=$?
  fi
  return $res
}

list_items() {
  if [ "$#" -eq "0" ]; then
    echo -en "Search for: "
    read search
    if [ -z "$search" ]; then
      echo "Error: Search field can't be empty"
      echo "Try again"
      list_items
    fi
    echo
  else
    find_lines "$search" | while read i
    do
      echo "$i" | tr ':' '\t'
  done
  echo -en "Matches found."
  num_lines "$search"
}