
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

num_lines()
{
  grep -i "$@" $BOOK | wc -l
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

add_item() {
  echo "Adding Details..."
  echo 
  echo -en "Name: "
  read name
  find_lines "^${name}:"
  if [ 'num_lines "^${name}:"' -ne "0" ]; then
    echo "$name already exist."
    return
  fi
  echo -en "Phone: "
  read phone
  echo -en "email: "
  read email

  echo "${name}:${phone}:${email}" >> $BOOK
  }