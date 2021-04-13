require("string")

local user_config = require("Shadertoys/~user_config")
local fuses       = require("Shadertoys/fuses")


fuses.fetch(user_config.pathToRepository..'Shaders/',false)


local YourTopLevelDomain='com'
local YourCompanyName='JiPi'
local YourPackageName='Shadertoys'
local PackageIdentifier='com.JiPi.Shadertoys'
local TargetFilepath=user_config.pathToRepository..'Atom/'
local YourPackageVersion='0.1'
local YourPackageDate='1999-04-01'


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

  if fuse.error==nil then

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

    OurPackageDescription=OurPackageDescription..descriptionIndent..'    <li>'..fuse.file_fusename..'</li>\n'


    local target_filename=
        -- fuse.file_category..'-'..
        -- fuse.file_fusename..'_'..
        fuse.shadertoy_id..'.fuse'

    -- quick hack:
    fuse.fuse_sourceCode=[[

      local FC_PREFIX=""
      local FC_AUTHBASEDLAYOUT=false
      local FC_SUBMENU="Shadertoys"
      local FC_DEVELOP=false

      ]]
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


  handle:write('[[\n')

  handle:write([[
        <center>
          <span style="color:#c0a050; font-size:x-large; font-weight:bold; ">Shaderfuse</span><br />
          <span style="color:#a0c050; font-size:large; font-style:italic; ">... welcome to the shaderverse</span><br />
          ]])

  handle:write(
          YourPackageName..[[ adds some Fuses that utilize DCTL to implement various Shaders as found on <a href="https://www.shadertoy.com/">Shadertoy.com</a>.<br />
          See our repository on <a href="https://github.com/nmbr73/Shadertoys">GitHub</a> for some insights and to maybe constribute to this project.<br />
          Find tons of example videos on what you can do with it on this <a href="https://www.youtube.com/c/JiPi_YT/videos">YouTube Channel</a>.<br />
          Please note that - unless stated otherwise - all these Fuses fall under Creative Commond 'CC BY-NC-SA 3.0 unported'.<br />
          This means that in particular any commercial use is strictliy prohibited!
        </center>]])

  handle:write(OurPackageDescription)

  handle:write([[
        <p>
          See the following videos for some examples:
          <ul>
            <li><a href="https://youtu.be/QE6--iYtikk">War of the Worlds</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/JiPi.html">JiPi</a></li>
            <li><a href="https://youtu.be/ktloT0pUaZg">HappyEastern</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/JiPi.html">JiPi</a></li>
            <li><a href="https://youtu.be/ntrp6BfVk0k">Shadertoy -Defilee</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/JiPi.html">JiPi</a></li>
            <li><a href="https://youtu.be/4R7ZVMyKLnY">Fire Water</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/JiPi.html">JiPi</a></li>
            <li><a href="https://youtu.be/oyndG0pLEQQ">Shadertoyparade</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/JiPi.html">JiPi</a></li>
            <li><a href="https://youtu.be/GJz8Vgi8Qws">The Shader Cut</a> by <a href="https://nmbr73.github.io/Shadertoys/Site/Profiles/nmbr73.html">nmbr73</a></li>
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
