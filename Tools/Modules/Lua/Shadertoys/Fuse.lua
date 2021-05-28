

-- ----------------------------------------------------------------------
-- WORK WITH A FUSE FILE
-- ----------------------------------------------------------------------
local Fuse = {
    file_filepath='',
    file_basepath='',
    file_category='',
    file_fusename='',
    file_filename='',

    thumbnail_exists = false,
    markdown_exists = false,

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
--   self.file_filepath=''
--   self.file_basepath=''
--   self.file_category=''
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



function Fuse:new(filepath)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o:init(filepath)

  return o
end


function Fuse:purge()
  self.fuse_sourceCode = ''
end


function Fuse:init(filepath)
  assert(filepath~=nil)

  self.file_filepath=filepath

  self.file_basepath, self.file_category, self.file_fusename =
    filepath:match('^(.+[/\\]Shaders/)([^/]+)/([^%.]+)%.fuse$')

  if self.file_basepath==nil or self.file_category==nil or self.file_fusename==nil then
    self.error="filepath '"..self.file_filepath.."' does not match the expected schema"
    return false
  end

  self.file_filename=self.file_fusename..'.fuse'

  if bmd.fileexists(self.file_basepath..self.file_category..'/'..self.file_fusename..'.md') then
    self.markdown_exists=true
  else
    self.markdown_exists=true
    self.error="markdown does not exists"
  end

  if bmd.fileexists(self.file_basepath..self.file_category..'/'..self.file_fusename..'_320x180.png') then
    self.thumbnail_exists=true
  else
    self.thumbnail_exists=true
    self.error="thumbnail does not exists"
  end


  return true
end


function Fuse:setError(txt,rv)
  assert(txt~=nil and txt~='')
  -- assert(self.file_fusename~=nil and self.file_fusename~='')
  -- self.error="in '"..self.file_category..'/'..self.file_fusename..".fuse': "..txt
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
  if self:hasErrors() or self.file_filepath==nil or self.file_filepath=='' then
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

  local f = io.open(self.file_filepath, "r")

  if not f then return self:setError("failed to read '"..self.file_filepath.."'",false) end

  self.fuse_sourceCode = f:read("*all")
  f:close()

  if self.fuse_sourceCode==nil or self.fuse_sourceCode=='' then return self:setError("failed to read content of file '"..self.file_filepath.."'",false) end

  local fields = {'shadertoy_name', 'shadertoy_author', 'shadertoy_id', 'dctlfuse_author', 'dctlfuse_name', 'dctlfuse_category', 'shadertoy_license'}

  for i, name in ipairs(fields) do
    local value=self.fuse_sourceCode:match('\n%s*local%s+'..name..'%s*=%s*"([^"]+)"') or self.fuse_sourceCode:match('^%s*local%s+'..name.."%s*=%s*'([^']+)'") or ''

    if value=='' and name=='dctlfuse_name' and self.fuse_sourceCode:match('\n%s*local%s+dctlfuse_name%s*=%s*shadertoy_name') then
      value = self.shadertoy_name
    end

    if value=='' and name~='shadertoy_license' then return self:setError("'"..name.."' could not be determined",false) end

    if name=='dctlfuse_name' and value~=self.file_fusename then return self:setError("Fuse name does not correspond to filename´",false) end

    self[name]=value
  end

  if not self.dctlfuse_name:match('^[A-Za-z][A-Za-z0-9_]*[A-Za-z0-9]$') then return self:setError("invalid fuse name '"..self.dctlfuse_name.."'",false) end
  if self.dctlfuse_name ~= self.file_fusename then return self:setError("fuse name '"..self.dctlfuse_name.."' does not match filename",false) end
  if not self.dctlfuse_category:match('^[A-Z][A-Za-z]+$') then return self:setError("invalid category name '"..self.dctlfuse_category.."'",false) end
  if self.dctlfuse_category ~= self.file_category then return self:setError("fuse category '"..self.dctlfuse_category.."' does not match fuse's subdirectory",false) end

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

  path = path and path or self.file_basepath..self.file_category..'/'

  filename = filename and filename or self.file_filename

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
  print(indent.."file_filepath='"..self.file_filepath.."'")
  print(indent.."file_basepath='"..self.file_basepath.."'")
  print(indent.."file_category='"..self.file_category.."'")
  print(indent.."file_fusename='"..self.file_fusename.."'")
  print(indent.."file_filename='"..self.file_filename.."'")

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
