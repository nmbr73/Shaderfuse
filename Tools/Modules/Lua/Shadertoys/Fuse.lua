--- A Fuse class.
--
-- Class to help to work with a fuse file.
--
-- Dependencies: `bmd.fileexists`
-- @classmod Fuse

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

    dctlfuse_versionDate = '',
    dctlfuse_authorurl = '',
    dctlfuse_authorlogo = '',

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
    self.markdown_exists=false
    self.error="markdown does not exists"
  end

  if bmd.fileexists(self.file_basepath..self.file_category..'/'..self.file_fusename..'_320x180.png') then
    self.thumbnail_exists=true
  else
    self.thumbnail_exists=false
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

  local optional_fields = {'dctlfuse_versionDate', 'dctlfuse_authorurl', 'dctlfuse_authorlogo'}

  for i, name in ipairs(optional_fields) do
    local value=self.fuse_sourceCode:match('\n%s*local%s+'..name..'%s*=%s*"([^"]+)"') or self.fuse_sourceCode:match('^%s*local%s+'..name.."%s*=%s*'([^']+)'") or ''
    self[name]=value
  end

  if self['dctlfuse_authorurl'] == "https://www.youtube.com/c/JiPi_YT" or self['dctlfuse_authorurl'] == "https://www.youtube.com/c/nmbr73" then
    self['dctlfuse_authorurl'] = ''
  end

  local nmbr73_authorlogo  = 'width="212" height="41" src="data:image/png;base64,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"'
  local jipi_authorlogo  = 'width="259" height="60" src="data:image/png;base64,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"'

  if self['dctlfuse_authorlogo'] == nmbr73_authorlogo or self['dctlfuse_authorlogo'] == jipi_authorlogo then
    self['dctlfuse_authorlogo'] = ''
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
