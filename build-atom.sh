 #!/usr/bin/env bash

ATOM_URI="com.JiPi.Shadertoys"

rm -rf atom
mkdir -p atom

cd 'Tools/Shell/'
lua generate_atom.lua
cd ../..

# sudo apt-get install zip
cd "Atom/${ATOM_URI}"
zip -r "../${ATOM_URI}.zip" Fuses "${ATOM_URI}.atom"

