require("string")

-- Fuse.Name
-- Fuse.Author
-- fuse.author_url
-- Shadertoy.ID
-- Shadertoy.Name
-- Shadertoy.Author
-- Shadertoy.License (default '(c) AUTHOR (CC BY-NC-SA 3.0)')

-- minilogo.image (default: '') ... '<img src="data:image/png;base64,..." />'
-- minilogo.width (default: 0)
-- minilogo.height (default: 0)
-- minilogo.image (default: '')
-- thumbnail.data (always exists, and always has a size of 320x180px)


Fuse = require("Shaderfuse/Fuse")
local fuses       = require("Shaderfuse/fuses")

local _error = nil



function set_error(msg)
  if not _error then
    _error = msg
  end
end

function has_error()
  return _error ~= nil
end

function get_error()
  return _error
end



function base64_decode(data)
  if not data then return nil end
  local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  data = string.gsub(data, '[^'..b..'=]', '')
  return (data:gsub('.', function(x)
    if (x == '=') then return '' end
    local r,f='',(b:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then return '' end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end



function base64_encode(data)
  if not data then return nil end
  local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  return ((data:gsub('.', function(x)
    local r,b='',x:byte()
    for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
    return r;
  end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
    if (#x < 6) then return '' end
    local c=0
    for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
    return b:sub(c+1,c+1)
  end)..({ '', '==', '=' })[#data%3+1])
end



function patch_installer_code(fuse,installer_code,fuse_code)

  if not installer_code then set_error("no installer_code for patch_installer_code()"); return nil end
  if not fuse_code then set_error("no fuse_code for patch_installer_code()"); return nil end


  installer_code = installer_code:gsub('{{> hash <}}',fuse.Commit.Hash)
  installer_code = installer_code:gsub('{{> hash15 <}}',string.sub(fuse.Commit.Hash,1,15))
  installer_code = installer_code:gsub('{{> version <}}',fuse.Commit.Version)
  installer_code = installer_code:gsub('{{> modified <}}',fuse.Commit.Date)
  installer_code = installer_code:gsub('{{> Fuse.Name <}}',fuse.Name)
  installer_code = installer_code:gsub('{{> Fuse.Author <}}',fuse.Author)
  installer_code = installer_code:gsub('{{> Fuse.AuthorURL <}}',fuse.Author)
  installer_code = installer_code:gsub('{{> Shadertoy.ID <}}',fuse.Shadertoy.ID)
  installer_code = installer_code:gsub('{{> Shadertoy.Name <}}',fuse.Shadertoy.Name)
  installer_code = installer_code:gsub('{{> Shadertoy.Author <}}',fuse.Shadertoy.Author)
  installer_code = installer_code:gsub('{{> Shadertoy.License <}}',fuse.Shadertoy.License)

  installer_code = installer_code:gsub('{{> thumbnail.data <}}',fuse.Thumbnail.Data)
  installer_code = installer_code:gsub('{{> fusecode.data <}}',base64_encode(fuse_code))

  local minilogo_width
  local minilogo_height
  local minilogo_image

  if fuse.Author == 'JiPi' then
    minilogo_width = 47
    minilogo_height = 24
    minilogo_image = '<img width="'.. minilogo_width ..'" height="'.. minilogo_height ..'" src="data:image/png;base64,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" />'
  elseif fuse.Author == 'nmbr73' then
    minilogo_width = 83
    minilogo_height = 16
    minilogo_image = '<img width="'.. minilogo_width ..'" height="'.. minilogo_height ..'" src="data:image/png;base64,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" />'
  else
    minilogo_width = 0
    minilogo_height = 0
    minilogo_image = ''
  end

  installer_code = installer_code:gsub('{{> minilogo.width <}}',minilogo_width)
  installer_code = installer_code:gsub('{{> minilogo.height <}}',minilogo_height)
  installer_code = installer_code:gsub('{{> minilogo.image <}}',minilogo_image)

  return installer_code
end



function patch_fuse_code(fuse,fuse_code)

  if not fuse_code then set_error("no code for patch_fuse_code()"); return nil end

  local n

  fuse_code, n = fuse_code:gsub('\n%s*local%s+ShaderFuse%s*=%s*require%("Shaderfuse/ShaderFuse"%)%s*\n','\n',1)
  if n ~= 1 then set_error("failed to eliminate ShaderFuse require statement"); return nil end

  fuse_code, n = fuse_code:gsub('\n%s*ShaderFuse%.init%(%)%s*\n','\n',1)
  if n ~= 1 then set_error("failed to eliminate ShaderFuse init statement"); return nil end

  fuse_code, n = fuse_code:gsub('ShaderFuse.FuRegister.Name','"'.. fuse.FuRegister.Name ..'"',1)
  if n ~= 1 then set_error("failed to eliminate ShaderFuse FuRegister.Name "); return nil end

  local furegister_attributes = '\n'

  for key, value in pairs(fuse.FuRegister.Attributes) do
    if type(value) == 'boolean' then
      value = value and 'true' or 'false'
    else
      value = value:gsub('\\','\\\\')
      value = '"'..value..'"'
    end

    furegister_attributes = furegister_attributes .. '  '.. key ..' = ' .. value ..',\n'
  end

  fuse_code, n = fuse_code:gsub('ShaderFuse.FuRegister.Attributes%s*,',furegister_attributes,1)
  if n ~= 1 then set_error("failed to eliminate ShaderFuse FuRegister.Attributs"); return nil end

  local begin_create = [[
        self:AddInput('<p align="center"><a href="https://github.com/nmbr73/Shadertoys"><img height="20" width="210" src="data:image/png;base64,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" /></a></p>',
          "ShaderfuseBranding", { IC_ControlPage = -1 , LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true, })]]

  fuse_code, n = fuse_code:gsub('\n%s*ShaderFuse%.begin_create%(%s*%)%s*\n',"\n"..begin_create.."\n",1)
  if n ~= 1 then set_error("failed to eliminate ShaderFuse.begin_create()"); return nil end

  local end_create =
       [[  ----- Info Tab]].."\n"
    .. [[  self:AddInput('<br /><p align="center">Shadertoy<br /><a href="https://www.shadertoy.com/view/]].. fuse.Shadertoy.ID ..[[" style="color:white; text-decoration:none; font-size:x-large; ">]]
        .. fuse.Shadertoy.Name ..[[</a><br />by <a href="https://www.shadertoy.com/user/]] .. fuse.Shadertoy.Author ..[[" style="color:#a0a060; text-decoration:none; ">]]
        .. fuse.Shadertoy.Author ..[[</a><br /><span style="color:#a06060; ">]]
        .. fuse.Shadertoy.License ..[[</span></p><p align="center">DCTLified and DaFused by <a href="]]
        .. (fuse.AuthorURL == '' and "https://nmbr73.github.io/Shadertoys/" or fuse.AuthorURL)
        ..[[" style="color:#f0f060; text-decoration:none; ">]].. fuse.Author
        ..[[</a><br />Version: <a href="https://github.com/nmbr73/Shadertoys/commit/]].. fuse.Commit.Hash .. [[" style color="color:#4060a0; ">]].. fuse.Commit.Version ..[[</a>&nbsp;/&nbsp;<span style="color:#ffffff; ">]].. fuse.Commit.Date .. [[</span></p><br />&nbsp;',]]
        ..[["ShaderfuseInfo", { ICS_ControlPage = "Info", IC_ControlPage = 1, LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true } )]] .."\n"
    .. [[  self:AddInput( "Fuse Info...", "ShaderfuseFuseInfoButton", { ICS_ControlPage = "Info", IC_ControlPage = 1, INPID_InputControl = "ButtonControl", INP_DoNotifyChanged = false, INP_External = false, BTNCS_Execute = 'bmd.openurl("]].. fuse.InfoURL .. [[")' })]] .."\n"
    .. [[  self:AddInput( "Shadertoy...", "ShaderfuseToyInfoButton", { ICS_ControlPage = "Info", IC_ControlPage = 1, INPID_InputControl = "ButtonControl", INP_DoNotifyChanged = false, INP_External = false, BTNCS_Execute = 'bmd.openurl("]].. fuse.Shadertoy.InfoURL ..[[")' })]] .."\n"
    .. [[  self:AddInput('<br /><p align="center"><img width="320" height="180" src="data:image/png;base64,]].. fuse.Thumbnail.Data ..[[" /></p>', "ShaderfuseThumbnail", { ICS_ControlPage = "Info", IC_ControlPage = 1, LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true } )]] .."\n"
    .. [[  self:AddInput('&nbsp;<br /><p>It seems that this version of the Fuse had been installed using a installer script. Please note that this means it has to be considered being an instable beta version!</p>', "ShaderfuseInstallInfo", { ICS_ControlPage = "Info", IC_ControlPage = 1, LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true } )]] .."\n"

  fuse_code, n = fuse_code:gsub('\n%s*ShaderFuse%.end_create%(%s*%)%s*\n',"\n\n"..end_create.."\n",1)
  if n ~= 1 then set_error("failed to eliminate ShaderFuse.end_create()"); return nil end

  return fuse_code
end



function read_fuse_thumbnail(fuse)

  if fuse.Thumbnail then return fuse.Thumbnail end

  local handle = io.open(fuse.DirName..'/'..fuse.Name..'.png', "rb")
  if not handle then set_error("failed to open "..fuse.DirName..'/'..fuse.Name..'.png'); return nil end
  local thumbnail_data = handle:read("*all")
  handle:close()

  return {
    Width = 320,
    Height = 180,
    Data = base64_encode(thumbnail_data),
  }

end



function get_fuse_commit_info(fuse)

  if fuse.Commit then return fuse.Commit end

  local handle = io.popen('git log -n 1 --pretty="format:%H %cs" -- '..fuse.DirName..'/'..fuse.Name..'.fuse')
  if not handle then set_error("failed to run 'git log'"); return nil end
  local git_output = handle:read("*a")
  handle:close()

  local hash, modified = git_output:match('^([0-9a-f]+) (20%d%d%-%d%d%-%d%d)%s*$')
  if not (hash and modified) then set_error("git log does not match expected output"); return nil end

  return { Hash = hash, Date = modified, Version = string.sub(hash,1,7) }

end


-------------------------------------------------------------------------------------------------------------------------------------------
-- Create installer script for a fuse.
--
-- @param[type=string|object] fuse The Fuse file's filepath or instance.

function installer_code(fuse)

    if type(fuse) == 'string' then
      fuse = Fuse:new(fuse,'installer',true)
    end

    if not fuse:isValid() then set_error("can't create installer for invalid Fuse"); return nil end

    local handle

    handle = io.open("Installer-code.lua", "r")
    if not handle then set_error("failed to open Installer-code.lua"); return nil end
    local installer_code = handle:read("*all")
    handle:close()

    handle = io.open(fuse.DirName..'/'..fuse.Name..'.fuse', "r")
    if not handle then return set_error("failed to open "..fuse.DirName..'/'..fuse.Name..'.fuse'); return nil end
    local fuse_code = handle:read("*all")
    handle:close()


    fuse.Thumbnail = read_fuse_thumbnail(fuse)
    fuse.Commit = get_fuse_commit_info(fuse)

    fuse_code = patch_fuse_code(fuse,fuse_code)

    -- fuse.Code = { Data = base64_encode(fuse_code),}
    installer_code = patch_installer_code(fuse,installer_code,fuse_code)

    return installer_code
end




function create_installer(fuse,repositorypath)

  if type(fuse) == 'string' then
    fuse = Fuse:new(fuse,'installer',true)
  end

  if not fuse:isValid() then return false end

  code = installer_code(fuse)

  if has_error() then print("ERROR: ".. get_error()); return false end

  local fpath = repositorypath..'docs/Installers/'..fuse.Category
  bmd.createdir(fpath)

  local fname = fuse.Name ..'-Installer.lua'
  local f = io.open(fpath..'/'..fname,"wb")
  if not f then print("ERROR: failed to open "..fname); return false end
  f:write(code)
  f:close()


end


function createInstallers(repositorypath)

    if not repositorypath then
      if user_config then
        repositorypath = user_config.pathToRepository
      else
        local user_config = require("Shaderfuse/~user_config")
        repositorypath = user_config.pathToRepository
      end
    end

    -- local fuse = Fuse:new("/Users/nmbr73/Projects/Shadertoys/Shaders/Wedding/Heartdemo.fuse")

    fuses.fetch(repositorypath..'/Shaders/','installer')

    for i, fuse in ipairs(fuses.list) do
        create_installer(fuse,repositorypath)

        -- print("Name: '".. fuse.Name .."'")
        -- fuse:read()
        -- fuse.fuse_sourceCode=snippet.replace(fuse.fuse_sourceCode)
    end


end



