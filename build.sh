 #!/usr/bin/env bash

rm -rf build
rm -rf docs
cp -rp Shaders docs
cp -rp Tools/Assets/Profiles docs

cd 'Tools/Shell/'
# lua generate_atom.lua
lua generate_csv.lua
lua generate_markdown.lua
lua generate_installer.lua
cd ..
cd ..

lua Tools/Shell/print_videos.lua > docs/Videos.md

cp Shaders.csv docs

# sudo apt-get install zip
cp -rp build/Shaderfuse-Installers/* docs
cd build
zip -r Shaderfuse-Installers.zip Shaderfuse-Installers
mv Shaderfuse-Installers.zip ../docs/

