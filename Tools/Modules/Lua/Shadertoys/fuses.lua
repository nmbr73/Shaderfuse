
Fuse = require("Shadertoys/Fuse")

local fuses = { list = nil }

-- function Fuses:new()
--   local o = {}
--   setmetatable(o, self)
--   self.__index = self
--   return o
-- end


function fuses.get_fuse(category,fusename)
  for i, f in ipairs(fuses.list) do
    if f.file_category == category and f.file_fusename == fusename then
      return f
    end
  end

  return nil
end

function fuses.fetch(
  path,     -- Full filepath to the folder containing the fuses
  details,  -- true, if the fuses shopuld be read for details; optional (default: false)
  list      -- must be nil
  )

  -- Traverses the directory 'path' and adds all files with the suffix
  -- 'suffix' to the 'list'. Files and directories stating with '.' are
  -- omitted!

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

  --return {}
end



return fuses
