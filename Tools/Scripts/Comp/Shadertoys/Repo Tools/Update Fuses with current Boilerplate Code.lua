
local user_config = require("Shadertoys/~user_config")
local snippet     = require("Shadertoys/snippet")
local fuses       = require("Shadertoys/fuses")

local marker_a  = "FUREGISTERCLASS"
local snippet_a = snippet.read(user_config.pathToRepository,marker_a)

local marker_b  = "SHADERFUSECONTROLS"
local snippet_b = snippet.read(user_config.pathToRepository,marker_b)



-- Versioning in the snippets is set on the basis
-- of https://en.wikipedia.org/wiki/List_of_minor_secular_observances

fuses.fetch(user_config.pathToRepository..'Shaders/',false)

local count_changed   = 0
local count_failed    = 0
local count_unchanged = 0


for i, fuse in ipairs(fuses.list) do

  fuse:read({CheckMarkers=false})

  if fuse.error==nil then

    local sourceCode=fuse.fuse_sourceCode

    sourceCode = snippet.replace(sourceCode,marker_a,snippet_a)
    sourceCode = snippet.replace(sourceCode,marker_b,snippet_b)

    if sourceCode==nil then
      count_failed=count_failed+1
      print("marker not found in in "..fuse.file_fusename)
    else
      if sourceCode==fuse.fuse_sourceCode then
        count_unchanged=count_unchanged+1
      else
        print("changed "..fuse.file_fusename)
        count_changed=count_changed+1
        fuse:write()
      end
    end

    fuse:purge()
  else
    print(fuse.file_fusename.." has error "..fuse.error)
  end
end

print("failed: "..count_failed)
print("changed: "..count_changed)
print("unchanged: "..count_unchanged)
