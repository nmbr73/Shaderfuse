


function read_snippet(path,marker)
                                                          ; assert(marker~=nil and marker~="")
  local handle=io.open(path..marker..".snippet.lua", "rb")    ; assert(handle)
  local content = handle:read("*all")
  handle:close()                                          ; assert(content~=nil and content~="")
                                                            assert(string.find(content, "-- >>> SCHNIPP::"..marker) ~= nil)
                                                            assert(string.find(content, "-- <<< SCHNAPP::"..marker) ~= nil)
  return content
end



function replace_snippet(fuse,marker,snippet)

  local mark_begin  = "-- >>> SCHNIPP::"..marker
  local mark_end    = "-- <<< SCHNAPP::"..marker

  local pos1 = string.find(fuse.fuse_sourceCode, mark_begin )
  local pos2 = string.find(fuse.fuse_sourceCode, mark_end )

  if pos1==nil then print("begin"..marker.." not found in "..fuse.file_fusename) end
  if pos2==nil then print("end"..marker.." not found in "..fuse.file_fusename) end


  if pos1 == nil or pos2==nil then return false end

  pos2 = pos2+string.len(mark_end)

  local new_sourceCode =
       string.sub(fuse.fuse_sourceCode,1,pos1-1)
    .. snippet
    .. string.sub(fuse.fuse_sourceCode,pos2)

  if fuse.fuse_sourceCode==new_sourceCode then
    return false
  end

  fuse.fuse_sourceCode=new_sourceCode
  return true
end



local user_config = require("Shadertoys/~user_config")
local fuses       = require("Shadertoys/fuses")
local path        = user_config.pathToRepository..'Tools/Boilerplate/'

local marker_a  = "FUREGISTERCLASS"
local snippet_a = read_snippet(path,marker_a)

local marker_b  = "SHADERFUSECONTROLS"
local snippet_b = read_snippet(path,marker_b)



-- Versioning in the snippets is set on the basis
-- of https://en.wikipedia.org/wiki/List_of_minor_secular_observances

fuses.fetch(user_config.pathToRepository..'Shaders/',false)

local count_changed=0
local count_unchanged=0


for i, fuse in ipairs(fuses.list) do

  fuse:read({CheckMarkers=false})

  if fuse.error==nil then

    local changed_a = replace_snippet(fuse,marker_a,snippet_a)
    local changed_b = replace_snippet(fuse,marker_b,snippet_b)

    if changed_a or changed_b then
      fuse:write()
      count_changed=count_changed+1
    else
      count_unchanged=count_unchanged+1
    end
    fuse:purge()
  else
    print(fuse.file_fusename.." has error "..fuse.error)
  end
end

print("changed: "..count_changed)
print("unchanged: "..count_unchanged)
