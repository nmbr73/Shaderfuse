

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

Persist the information on where to find the repository ...
```
REPO=`pwd`

echo "local user_config = { pathToRepository = '$REPO/' }\nreturn user_config" \
 > $REPO/Tools/Modules/Lua/Shadertoys/\~user_config.lua

BMD=~/Library/Application\ Support/Blackmagic\ Design
```

... and in the same shell set symbolic links for Fusion to point into your working copy:

```
cd "$BMD/Fusion/Modules/Lua"
ln -s "$REPO/Tools/Modules/Lua/Shadertoys" Shadertoys
cd "$BMD/Fusion/Scripts/Comp"
ln -s "$REPO/Tools/Scripts/Comp/Shadertoys" Shadertoys
````

... resp. do so for Resolve:
```
cd "$BMD/DaVinci Resolve/Fusion/Modules/Lua"
ln -s "$REPO/Tools/Modules/Lua/Shadertoys" Shadertoys
cd "$BMD/DaVinci Resolve/Fusion/Scripts/Comp"
ln -s "$REPO/Tools/Scripts/Comp/Shadertoys" Shadertoys
````
