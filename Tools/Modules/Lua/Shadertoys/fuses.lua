--- A list of fuses.
--
-- This module scanns all the files in the repository and manages all
-- the fuses found in a list of Fuse objects.
--
--    local fuses = require("Shadertoys/fuses")
--    fuses.fetch(user_config.pathToRepository..'Shaders/',false)
--    for i, fuse in ipairs(fuses.list) do
--      fuse:read()
--      ...
--
-- Dependencies: `bmd.readdir`
-- @module fuses



Fuse = require("Shadertoys/Fuse")



-------------------------------------------------------------------------------------------------------------------------------------------
-- Local structure to manage the Fuse objects.
--
-- This hash `fuses` contains a `list` structure with the valid Fuse object instances and with `categories` the names of the folders those
-- Fuses were found in.
--
-- @table fuses
-- @field list A structure to manage a list of fuses.
-- @field categories Hash to look up categories.
--
local fuses = {
  list = nil,
  categories = {}
}



-------------------------------------------------------------------------------------------------------------------------------------------
-- Get a fuse object form the list of fuses.
--
-- Searches in the list of fuses for an object of category `category` and the name `fusename`.
--
-- @param[type=string] category The category (folder name in the Shaders subdirectory) to search in
-- @param[type=string] fusename The name (file name without suffix) of the fuse to search for
-- @return[type=Fuse] the Fuse object; `nil` if not found
--
function fuses.get_fuse(category,fusename)
  for i, f in ipairs(fuses.list) do
    if f.file_category == category and f.file_fusename == fusename then
      return f
    end
  end

  return nil
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Initialize the `fuses` structure.
--
-- Traverses the `path` and searches for Fuses to add them to the `fuses.list`.
--
-- @param[type=string] path The path to search through for fuse files.
-- @param[type=bool,opt=false] details true, if the fuses should be read for details
--
function fuses.fetch(path, details, list)

  -- 'list' parameter is only for internal use to recursively call 'fetch()''.

  assert(path)

  if list==nil then
    list = {}

    if path==nil or path=="" then
      return list
    end

    if string.sub(path,-1) ~= "/" then
      path = path.."/"
    end

    fuses.fetch(path, false, list)

    if details~=nil and details then
      for i, f in ipairs(list) do
        f:read()
        f:purge()
      end
    end

    table.sort(list,function(a,b) return a.file_category < b.file_category or (a.file_category == b.file_category and a.file_fusename < b.file_fusename ) end)

    fuses.list = list

    fuses.categories = {}
    local cat = ''
    for i, fuse in ipairs(fuses.list) do
      if fuse.file_category~=cat then
        cat=fuse.file_category
        table.insert(fuses.categories,cat)
      end
    end

    table.sort(fuses.categories)

  else

    local handle	= bmd.readdir(path .. "*")

    for k, v in pairs(handle) do
      if (v.Name ~= nil and string.sub(v.Name,0,1) ~= ".") then
        if (v.IsDir == false) then
          if string.sub(v.Name,-5) == '.fuse' then
            table.insert(list,Fuse:new(path..v.Name))
          end
        else
          fuses.fetch(path..v.Name.."/", false, list )
        end
      end
    end

  end

end



return fuses
