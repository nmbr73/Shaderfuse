require("string")
-- local ui = require "Tools.Modules.Lua.Shadertoys.ui"
local ui          = require("Shadertoys/ui") -- for the logo

local user_config = require("Shadertoys/~user_config")
local snippet     = require("Shadertoys/snippet")
local fuses       = require("Shadertoys/fuses")


snippet.init(user_config.pathToRepository,'reactor',false)
fuses.fetch(user_config.pathToRepository..'Shaders/',false)


local YourTopLevelDomain='com'
local YourCompanyName='JiPi'
local YourPackageName='Shadertoys'
local PackageIdentifier='com.JiPi.Shadertoys'
local TargetFilepath=user_config.pathToRepository..'Atom/'
local YourPackageVersion='1.0'
local YourPackageDate=os.date("%Y,%m,%d")


-- com.YourCompanyName.YourPackageName (folder)
--     com.YourCompanyName.YourPackageName.atom (file)
--     Macros  (folder)
--         YourCompanyName (folder)
--         your-custom.bmp (file)
--         your-custom.setting (file)
--     Fuses (folder)
--         your-custom.fuse (file)
--     Scripts (folder)
--         Comp (folder)
--         YourCompanyName (folder)
--         your-script.lua (file)


bmd.createdir(TargetFilepath..PackageIdentifier)
-- bmd.createdir(TargetFilepath..PackageIdentifier.'/Macros')
-- bmd.createdir(TargetFilepath..PackageIdentifier.'/Macros/'..YourCompanyName)
bmd.createdir(TargetFilepath..PackageIdentifier..'/Fuses')
bmd.createdir(TargetFilepath..PackageIdentifier..'/Fuses/Shadertoys_wsl')
-- bmd.createdir(TargetFilepath..PackageIdentifier.'/Scripts')
-- bmd.createdir(TargetFilepath..PackageIdentifier.'/Scripts/Comp')
-- bmd.createdir(TargetFilepath..PackageIdentifier.'/Scripts/'..YourCompanyName)



local OurPackageDescription=''
local OurDeployments=''



local currentCategory=''
local descriptionIndent='        '

for i, fuse in ipairs(fuses.list) do

  fuse:read()

  fuse.fuse_sourceCode=snippet.replace(fuse.fuse_sourceCode)

  if fuse.error==nil and fuse.fuse_sourceCode~=nil then

    if fuse.file_category ~= currentCategory then

      if currentCategory~='' then
        OurPackageDescription=OurPackageDescription
          ..descriptionIndent..'  </ul>\n'
          ..descriptionIndent..'</p>\n'
      end

      currentCategory=fuse.file_category

      OurPackageDescription=OurPackageDescription..
        descriptionIndent..'<p>\n'..
        descriptionIndent..'    '..currentCategory..' Shaders:\n'..
        descriptionIndent..'  <ul>\n'

    end

    OurPackageDescription=OurPackageDescription..descriptionIndent..'    <li><strong style="color:#c0a050; ">'..fuse.file_fusename..'</strong></li>\n'


    local target_filename=
        -- fuse.file_category..'-'..
        -- fuse.file_fusename..'_'..
        fuse.shadertoy_id..'.fuse'


    fuse.fuse_sourceCode=string.gsub(fuse.fuse_sourceCode, "%sdctlfuse_authorlogo%s*=%s*'([^']*)'", " dctlfuse_authorlogo=nil" )


    fuse.fuse_sourceCode=[[

--
--       _____        _   _       _   ______    _ _ _
--      |  __ \      | \ | |     | | |  ____|  | (_) |
--      | |  | | ___ |  \| | ___ | |_| |__   __| |_| |_
--      | |  | |/ _ \| . ` |/ _ \| __|  __| / _` | | __|
--      | |__| | (_) | |\  | (_) | |_| |___| (_| | | |_
--      |_____/ \___/|_| \_|\___/ \__|______\__,_|_|\__|
--
--   ... this File is managed by some scripts and can be
--    overwritten at any time and without further notice!
--         pls. see https://github.com/nmbr73/Shadertoys
--                                           for details
--

]]

      .."local SHADERFUSES_REACTOR_PACKAGE_VERSION = '"..YourPackageVersion.."'\n"
      .."local SHADERFUSES_REACTOR_PACKAGE_DATE    = '"..(os.date("%b %Y")).."'\n\n"
      ..fuse.fuse_sourceCode


    fuse:write(
      TargetFilepath..PackageIdentifier..'/Fuses/Shadertoys_wsl/',
      target_filename
      )
    fuse:purge()

    OurDeployments=OurDeployments..'          "Fuses/Shadertoys_wsl/'..target_filename..'",\n'

  end
end

if currentCategory~='' then
  OurPackageDescription=OurPackageDescription
  ..descriptionIndent..'  </ul>\n'
  ..descriptionIndent..'</p>\n'
end




local handle = io.open(TargetFilepath..PackageIdentifier..'/'..PackageIdentifier..'.atom',"wb")

if handle then

  handle:write([[
    Atom {
      Name = "]]..YourPackageName..[[",
      Category = "Shaders",
      Author = "]]..YourCompanyName..[[",
      Version = ]]..YourPackageVersion..[[,
      Date = {]]..YourPackageDate..[[},

      Description = ]]
    )


  handle:write('[[\n        <center>\n')


    if true then
      handle:write('          <br />')
      handle:write(ui.logo_string)
      handle:write('<br /><br />\n')
    else
      handle:write([[
          <span style="color:#c0a050; font-size:x-large; font-weight:bold; ">Shaderfuse</span><br />
          <span style="color:#a0c050; font-size:large; font-style:italic; ">... welcome to the shaderverse</span><br />
          ]])
    end

  handle:write(
          '          The package <font color="white">'..
          YourPackageName..[[</font> adds some Fuses that utilize DCTL to implement various Shaders as found on <a href="https://www.shadertoy.com/">Shadertoy.com</a>.<br />
          See our repository on <a href="https://github.com/nmbr73/Shadertoys">GitHub</a> for some insights and to maybe constribute to this project?!?<br />
          Find tons of example videos on what you can do with it on JiPi's <a href="https://www.youtube.com/c/JiPi_YT/videos">YouTube Channel</a>.<br />
          Please note that - unless stated otherwise - all these Fuses fall under Creative Commond 'CC BY-NC-SA 3.0 unported'.<br />
          For most shaders this regrettably means that in particular <font color="#ff6060">any commercial use is strictliy prohibited!</font>
        </center>
        ]])

  handle:write(OurPackageDescription)



  handle:write([[
        <p>
          See the following videos for some examples:
          <ul>
            <li><a href="https://youtu.be/GJz8Vgi8Qws">The Shader Cut</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/nmbr73.html" style="color:#a05050; ">nmbr73</a> and</li>
            <li><a href="https://youtu.be/8sUu5GcDako">Other Worlds</a>,</li>
            <li><a href="https://youtu.be/OYOar65omeM">Lego</a>,</li>
            <li><a href="https://youtu.be/WGWCrhPNmdg">Mahnah Mahnah</a>,</li>
            <li><a href="https://youtu.be/QE6--iYtikk">War of the Worlds</a>,</li>
            <li><a href="https://youtu.be/ktloT0pUaZg">HappyEastern</a>,</li>
            <li><a href="https://youtu.be/ntrp6BfVk0k">Shadertoy -Defilee</a>,</li>
            <li><a href="https://youtu.be/4R7ZVMyKLnY">Fire Water</a>,</li>
            <li><a href="https://youtu.be/oyndG0pLEQQ">Shadertoyparade</a> all by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/JiPi.html" style="color:#a05050; ">JiPi</a></li>
          </ul>
        </p>]])

  handle:write(']]')

  handle:write([[,
      Deploy = {]]..'\n'.. OurDeployments ..[[
      },

      Dependencies = {},
  }]])

  handle:close()
end
