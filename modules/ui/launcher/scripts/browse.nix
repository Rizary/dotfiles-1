{ writeScript, bash, chromium }:

writeScript "browse" ''
  #! ${bash}/bin/sh

  chromium=${chromium}/bin/chromium

  if [[ $1 =~ :\/\/ ]]
  then
      target=$1
  elif [[ $1 =~ ^/ ]]
  then
      target="file://$1"
  elif [[ $1 =~ ^go/ ]]
  then
      target="https://go.netflix.com/''${1##go/}"
  else
      target="http://$1"
  fi

  export LD_PRELOAD=
  exec $chromium --enable-native-gpu-memory-buffers --app=$target >/dev/null 2>&1
  #exec minichrome browse $target >/dev/null 2>&1
''
