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



function base64_decode(data)
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



function createInstaller(fusefilepath)

    local handle
    local fuse = Fuse:new(fusefilepath,'installer',true)

    handle = io.open("Installer-code.lua", "r")
    if not handle then return "failed to open Installer-code.lua" end
    local installer_code = handle:read("*all")
    handle:close()

    handle = io.open(fuse.DirName..'/'..fuse.Name..'.fuse', "r")
    if not handle then return "failed to open "..fuse.DirName..'/'..fuse.Name..'.fuse' end
    local fuse_code = handle:read("*all")
    handle:close()

    handle = io.open(fuse.DirName..'/'..fuse.Name..'.png', "rb")
    if not handle then return "failed to open "..fuse.DirName..'/'..fuse.Name..'.png' end
    local thumbnail_data = handle:read("*all")
    handle:close()
    thumbnail_data = base64_encode(thumbnail_data)


    handle = io.popen('git log -n 1 --pretty="format:%H %cs" -- '..fuse.DirName..'/'..fuse.Name..'.fuse')
    if not handle then return "failed to run 'git log'" end
    local git_output = handle:read("*a")
    handle:close()

    local hash, modified = git_output:match('^([0-9a-f]+) (20%d%d%-%d%d%-%d%d)%s*$')

    hash = hash or ''
    modified = modified or ''
    local version = string.sub(hash,1,7)
    local hash15 = string.sub(hash,1,15)

    installer_code = installer_code.gsub(installer_code,'{{> hash <}}',hash)
    installer_code = installer_code.gsub(installer_code,'{{> hash15 <}}',hash15)
    installer_code = installer_code.gsub(installer_code,'{{> version <}}',version)
    installer_code = installer_code.gsub(installer_code,'{{> modified <}}',modified)
    installer_code = installer_code.gsub(installer_code,'{{> thumbnail.data <}}',thumbnail_data)
    installer_code = installer_code.gsub(installer_code,'{{> Fuse.Name <}}',fuse.Name)
    installer_code = installer_code.gsub(installer_code,'{{> Fuse.Author <}}',fuse.Author)
    installer_code = installer_code.gsub(installer_code,'{{> Fuse.AuthorURL <}}',fuse.Author)
    installer_code = installer_code.gsub(installer_code,'{{> Shadertoy.ID <}}',fuse.Shadertoy.ID)
    installer_code = installer_code.gsub(installer_code,'{{> Shadertoy.Name <}}',fuse.Shadertoy.Name)
    installer_code = installer_code.gsub(installer_code,'{{> Shadertoy.Author <}}',fuse.Shadertoy.Author)
    installer_code = installer_code.gsub(installer_code,'{{> Shadertoy.License <}}',fuse.Shadertoy.License)

    -- {{> minilogo.width <}}
    -- {{> minilogo.height <}}
    -- {{> minilogo.image <}}

    -- print(git_output)
    print(installer_code)
    -- fuse:print()
    return nil
end


function createInstallers(repositorypath)

    -- local fuse = Fuse:new("/Users/nmbr73/Projects/Shadertoys/Shaders/Wedding/Heartdemo.fuse")

    fuses.fetch(repositorypath..'/Shaders/',false)

    for i, fuse in ipairs(fuses.list) do

        print("Name: '".. fuse.Name .."'")
        -- fuse:read()
        -- fuse.fuse_sourceCode=snippet.replace(fuse.fuse_sourceCode)


    end


end

