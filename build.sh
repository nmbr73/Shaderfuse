#!/usr/bin/env bash

ATOM_URI="com.JiPi.Shadertoys"

# ----------------------------------------------------------------------------

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SCRIPTNAME=`basename $0`

set -o errexit
set -o pipefail
set -o nounset

if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

cd "$(dirname "$0")"

# ----------------------------------------------------------------------------

function do_clean {
  rm -rf assets
  rm -rf atom
  rm -rf build
  rm -rf docs
  rm -rf site
  rm -f Shaders.csv
}

# ----------------------------------------------------------------------------

function do_csv {
  rm -f Shaders.csv
  cd 'Tools/Shell/'
  lua generate_csv.lua
  cd ../..
}

# ----------------------------------------------------------------------------

function do_atom {

  rm -rf atom
  mkdir atom

  cd 'Tools/Shell/'
  lua generate_atom.lua
  cd ../..


  cd "atom/${ATOM_URI}"
  [ -f ../atomizer.sh ] && sh ../atomizer.sh
  cd ../..

}

# ----------------------------------------------------------------------------

function do_installers {

  rm -rf build/Shaderfuse-Installers
  rm -f build/Shaderfuse-Installers.zip

  cd 'Tools/Shell/'
  lua generate_installer.lua
  cd ../..

  cd build
  zip -r Shaderfuse-Installers.zip Shaderfuse-Installers
  cd ..
}

# ----------------------------------------------------------------------------

function do_assets {
  # this function does just call some of the other
  # do_whatsoever functions to then move theire
  # generated output into an assets/ directory that
  # can then be used as a source for the assets to
  # be uploaded with a new GitHub release.

  rm -rf assets
  mkdir -p assets

  do_csv
  mv Shaders.csv assets/Shaderfuses.csv

  do_atom
  mv "atom/${ATOM_URI}.zip" assets/
  rm -rf atom

  do_installers
  mv build/Shaderfuse-Installers.zip assets/
  rm -rf build/Shaderfuse-Installers
}

# ----------------------------------------------------------------------------

function do_docs {

  rm -rf docs

  # copy Shades/ as a basis
  cp -rp Shaders docs

  # add some more markdown files
  cp -rp Tools/Assets/Profiles docs
  cp -rp Tools/Documentation docs/

  # patch the markdown files and generate overviews
  cd 'Tools/Shell/'
  lua generate_markdown.lua
  cd ../..

  # create the videos list file
  lua Tools/Shell/print_videos.lua > docs/Videos.md

  # create the installers, as they are referenced in the markdown files
  do_installers
  cp -rp build/Shaderfuse-Installers/* docs
  mv build/Shaderfuse-Installers.zip docs/
  rm -rf build/Shaderfuse-Installers/
}

# ----------------------------------------------------------------------------

main() {

  local COMMAND="${1-}"

  case $COMMAND in

    "clean")
      do_clean
      ;;

    "csv")
      do_csv
      ;;

    "assets")
      do_assets
      ;;

    "docs")
      do_docs
      ;;

    "atom")
      do_atom
      ;;

    "installers")
      do_installers
      ;;

    "help" | "-h" | "--help")
      echo ""
      echo "Usage:"
      echo ""
      echo "    $SCRIPTNAME <command>"
      echo ""
      echo "The commands are:"
      echo ""
      echo "  atom         create the atom package under 'atom/'"
      echo "  csv          create Shaders.csv with a list of all the shaders"
      echo "  assets       create 'assets/' with files to add to a GitHub release"
      echo "  installers   create the drag'n'drop installer lua scripts"
      echo "  docs         create all the input needed for mkdocs"
      echo "  clean        delete any of the autogenerated / temporary content"
      echo ""
      ;;

    *)
      echo "unknown command '$COMMAND'" >&2
      echo "try '$SCRIPTNAME help' for usage" >&2
      exit 10
      ;;
  esac

}


main "$@"
