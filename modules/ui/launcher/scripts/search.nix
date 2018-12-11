{ writeScript, bash, coreutils, gnugrep, gnused }:

writeScript "search" ''
  #! ${bash}/bin/sh

  printf=${coreutils}/bin/printf
  echo=${coreutils}/bin/echo
  grep=${gnugrep}/bin/grep
  sed=${gnused}/bin/sed
  browse=@out@/bin/browse

  declare -A engines=(
      ["!g"]="https://google.com/search?q=%QUERY%"
      ["!a"]="https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=%QUERY%"
      ["!amazon"]="https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=%QUERY%"
      ["!maps"]="https://www.google.com/maps/search/%QUERY%"
      ["!wiki"]="https://en.wikipedia.org/wiki/Special:Search?search=%QUERY%"
      ["!w"]="https://en.wikipedia.org/wiki/Special:Search?search=%QUERY%"
      ["!yt"]="https://www.youtube.com/results?search_query=%QUERY%"
      ["!im"]="https://www.google.com/search?q=%QUERY%&tbm=isch"
      ["!i"]="https://www.google.com/search?q=%QUERY%&tbm=isch"
      ["!aw"]="https://wiki.archlinux.org/index.php?title=Special%3ASearch&search=%QUERY%"
      ["!aur"]="https://aur.archlinux.org/packages/?O=0&K=%QUERY%"
  )
  default_engine="https://google.com/search?q=%QUERY%"

  urlencode() {
    local length="''${#1}"
    for (( i = 0; i < length; i++ )); do
      local c="''${1:i:1}"
      case $c in
        [a-zA-Z0-9.~_-]) $printf "$c" ;;
        *) $printf '%%%02X' "'$c"
      esac
    done
  }

  query="$*"
  engine="$default_engine"

  for matcher in "''${!engines[@]}"; do
    if $echo "$query" | $grep -qE '(^|\s)'"$matcher"'($|\s)'
    then
      query=$($echo "$query" | $sed "s/$matcher//")
      engine="''${engines[$matcher]}"
    fi
  done

  query=$(urlencode "$($echo "$query" | $sed 's/^[[:space:]]*//;s/[[:space:]]*$//')")

  exec $browse "''${engine/\%QUERY\%/$query}"
''
