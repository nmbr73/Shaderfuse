--- A Fuse class.
--
-- Class to help to work with a fuse file.
--
-- Dependencies: `bmd.fileexists`, `Shadertoys/ShaderFuse`
-- @classmod Fuse


ShaderFuse = require("Shadertoys/ShaderFuse")

local Fuse = {
    Name='', -- Fuse (file)name (without suffix)
    FilePath='', -- Fuse filepath (full path, incl. category and suffix)
    DirName='',  -- Fuse path (incl. Category, without trailing slash)
    Category='',

    thumbnail_exists = false,
    markdown_exists  = false,
    fuseinfo_exists  = false,

    error = nil,

    shadertoy_name = '',
    shadertoy_author = '',
    shadertoy_id = '',
    shadertoy_license = '',
    dctlfuse_category = '',
    dctlfuse_name = '',
    dctlfuse_author = '',


    fuse_sourceCode = nil,
}


-- function Fuse:clear()
--   self.FilePath=''
--   self.Category=''
--   self.file_name=''

--   self.error = nil

--   self.shadertoy_name = ''
--   self.shadertoy_author = ''
--   self.shadertoy_id = ''
--   self.shadertoy_license = ''
--   self.dctlfuse_category = ''
--   self.dctlfuse_name = ''
--   self.dctlfuse_author = ''

--   self.fuse_sourceCode = nil
-- end



------------------------------------------------------------------------------
-- Create an instance.
--
function Fuse:new(filepath)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o:init(filepath)

  return o
end



------------------------------------------------------------------------------
-- Save some memory.
--
function Fuse:purge()
  self.fuse_sourceCode = ''
end



------------------------------------------------------------------------------
-- Initialize the object.
--
function Fuse:init(filepath)

  -- ShaderFuse.init(filepath)



  assert(filepath~=nil)

  self.FilePath=filepath

  self.DirName, self.Category, self.Name =
    filepath:match('^(.+[/\\]Shaders/)([^/]+)/([^%.]+)%.fuse$')

  if self.DirName==nil or self.Category==nil or self.Name==nil then
    self.error="filepath '"..self.FilePath.."' does not match the expected schema"
    return false
  end

  self.DirName = self.DirName .. self.Category

  if bmd.fileexists(self.DirName..'/'..self.Name..'.md') then
    self.markdown_exists=true
  else
    self.markdown_exists=false
    self.error="markdown does not exists"
  end

  if bmd.fileexists(self.DirName..'/'..self.Name..'_320x180.png') then
    self.thumbnail_exists=true
  else
    self.thumbnail_exists=false
    self.error="thumbnail does not exists"
  end


  if bmd.fileexists(self.DirName..'/'..self.Name..'.sfi') then
    self.fuseinfo_exists=true
  else
    self.fuseinfo_exists=false
    self.error="fuse info file does not exists"
  end


  return true
end


function Fuse:setError(txt,rv)
  assert(txt~=nil and txt~='')
  -- assert(self.Name~=nil and self.Name~='')
  -- self.error="in '"..self.Category..'/'..self.Name..".fuse': "..txt
  self.error=txt
  return rv
end


function Fuse:hasErrors()
  assert(self ~= nil)
  if self.error ~= nil and self.error ~='' then
    return true
  end
  return false
end

function Fuse:isValid()
  assert(self ~= nil)
  if self:hasErrors() or self.FilePath==nil or self.FilePath=='' then
    return false
  end
  return true
end


function Fuse:getErrorText()
  assert(self ~= nil)
  if self.error ~= nil then
    return self.error
  end
  return ''
end


function Fuse:read(options)
	assert(self.fuse_sourceCode==nil)

--  if not self:isValid() then return false end

  local f = io.open(self.FilePath, "r")

  if not f then return self:setError("failed to read '"..self.FilePath.."'",false) end

  self.fuse_sourceCode = f:read("*all")
  f:close()

  if self.fuse_sourceCode==nil or self.fuse_sourceCode=='' then return self:setError("failed to read content of file '"..self.FilePath.."'",false) end

  local fields = {'shadertoy_name', 'shadertoy_author', 'shadertoy_id', 'dctlfuse_author', 'dctlfuse_name', 'dctlfuse_category', 'shadertoy_license'}

  for i, name in ipairs(fields) do
    local value=self.fuse_sourceCode:match('\n%s*local%s+'..name..'%s*=%s*"([^"]+)"') or self.fuse_sourceCode:match('\n%s*local%s+'..name.."%s*=%s*'([^']+)'") or ''

    if value=='' and name=='dctlfuse_name' and self.fuse_sourceCode:match('\n%s*local%s+dctlfuse_name%s*=%s*shadertoy_name') then
      value = self.shadertoy_name
    end

    if value=='' and name~='shadertoy_license' then return self:setError("'"..name.."' could not be determined",false) end

    if name=='dctlfuse_name' and value~=self.Name then return self:setError("Fuse name does not correspond to filename´",false) end

    self[name]=value
  end



  if not self.dctlfuse_name:match('^[A-Za-z][A-Za-z0-9_]*[A-Za-z0-9]$') then return self:setError("invalid fuse name '"..self.dctlfuse_name.."'",false) end
  if self.dctlfuse_name ~= self.Name then return self:setError("fuse name '"..self.dctlfuse_name.."' does not match filename",false) end
  if not self.dctlfuse_category:match('^[A-Z][A-Za-z]+$') then return self:setError("invalid category name '"..self.dctlfuse_category.."'",false) end
  if self.dctlfuse_category ~= self.Category then return self:setError("fuse category '"..self.dctlfuse_category.."' does not match fuse's subdirectory",false) end

  local markers={
      '-- >>> SCHNIPP::FUREGISTERCLASS.version="MonumentsAndSites"',
      '-- <<< SCHNAPP::FUREGISTERCLASS',
      '-- >>> SCHNIPP::SHADERFUSECONTROLS.version="MonumentsAndSites"',
      '-- <<< SCHNAPP::SHADERFUSECONTROLS',
    }


  if options ~= nil and options.CheckMarkers ~= nil and options.CheckMarkers==false then

  else
    for i, marker in ipairs(markers) do
      if string.find(self.fuse_sourceCode, marker) == nil then
        return self:setError('fuse must contain the standard and unmodified SCHNIPP/SCHNAPP text blocks',false)
      end
    end
  end



  return true

end

function Fuse:write(path,filename)

  path = path and path or self.DirName..'/'

  filename = filename and filename or self.Name .. '.fuse'

  assert(self.fuse_sourceCode~=nil)
  assert(self.fuse_sourceCode~='')

  local f = io.open(path..filename,"w")

  if f then
    f:write(self.fuse_sourceCode)
    f:close()
  end

end



function Fuse:print(indent)
  indent = indent and indent or ""
  print(indent.."FilePath='"..self.FilePath.."'")
  print(indent.."DirName='"..self.DirName.."'")
  print(indent.."Category='"..self.Category.."'")
  print(indent.."Name='"..self.Name.."'")

  if self:hasErrors() then
    print(indent.."error: ".. self:getErrorText())
  else
    print(indent.."shadertoy_name='"..self.shadertoy_name.."'")
    print(indent.."shadertoy_author='"..self.shadertoy_author.."'")
    print(indent.."shadertoy_id='"..self.shadertoy_id.."'")
    print(indent.."shadertoy_license='"..self.shadertoy_license.."'")
    print(indent.."dctlfuse_category='"..self.dctlfuse_category.."'")
    print(indent.."dctlfuse_name='"..self.dctlfuse_name.."'")
    print(indent.."dctlfuse_author='"..self.dctlfuse_author.."'")
  end
end



return Fuse
