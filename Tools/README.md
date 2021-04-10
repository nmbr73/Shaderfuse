

# Tools

This one is to ... hm ... okay - it does nothing because it is under construction.

## Install Manually

Copy the folder `Shadertoys` from `Shadertoys/Tools/Scripts/Comp/`to your `Scripts/Comp/` folder.<br />
Copy the folder `Shadertoys` from `Shadertoys/Tools/Modules/Lua/`to your `Modules/Lua` folder.<br />
Create a file `Shadertoys/~user_config.lua` in your `Modules/Lua/` folder.<br />
Edit that `~user_config.lua` file to contain the following text:
```lua
local user_config = { pathToRepository = '<PATHTOYOURREPO>/' }
return user_config
```
with `<PATHTOYOURREPO>`the path to your working copy of the repositoy.

## Install on Mac

cd into your working copy ... in my case I cloned the repository into ‘~/Projects/':

```
cd ~/Projects/Shadertoys/
````

then set symbolic links for Fusion to point into your working copy:

```
REPO=`pwd`

echo "local user_config = { pathToRepository = '$REPO/' }\nreturn user_config" \
 > $REPO/Tools/Modules/Lua/Shadertoys/\~user_config.lua

cd ~/Library/Application\ Support/Blackmagic\ Design/Fusion/Modules/Lua
ln -s "$REPO/Tools/Modules/Lua/Shadertoys" Shadertoys
cd ~/Library/Application\ Support/Blackmagic\ Design/Fusion/Scripts/Comp
ln -s "$REPO/Tools/Scripts/Comp/Shadertoys" Shadertoys
````
