{ writeScript, bash }:

writeScript "netflix" ''
  #! ${bash}/bin/sh

  browse=@out@/bin/browse

  case $1 in
    testers) url='https://tenfootuiapps.netflix.com/' ;;

    local) url='https://lyra.corp.netflix.com/browse' ;;
    develop-int) url='https://develop-int.test.netflix.com/' ;;
    int|release-int) url='https://release-int.test.netflix.com/' ;;
    qa|develop-stage) url='https://develop-stage.netflix.com' ;;
    stage|release-stage) url='https://release-stage.netflix.com' ;;

    reno) url='https://map.builds.test.netflix.net/view/Reno/' ;;

    repl) url='https://api-staging-internal.netflix.com/internal/repl' ;;
    repl-prod) url='https://api-internal.netflix.com/internal/repl' ;;
    repl-int) url='https://api-int-internal.test.netflix.com/internal/repl' ;;
    repl-test) url='https://api-internal.test.netflix.com/internal/repl' ;;

    dvds) url='dvd-www-test-baseline-stable.eng.dvdco.netflix.com' ;;

    *) url='http://www.netflix.com' ;;
  esac

  exec $browse $url
''
