require("string")

local user_config = require("Shadertoys/~user_config")
-- local Fuse        = require("Shadertoys/Fuse")
local fuses        = require("Shadertoys/fuses")
local util        = require("Shadertoys/util")
local ui          = require("Shadertoys/ui")

print("sep '"..util.path_separator.."'")
print("path '".. user_config.pathToRepository .."'")





-- local fuses = Fuses:new()


fuses.fetch(user_config.pathToRepository..'Shaders/')

--table.sort(fuses,function(t,a,b) return t[b].file_category < t[a].file_category or (t[b].file_category == t[a].file_category and t[b].file_fusename < t[a].file_fusename ) end)

for i, f in ipairs(fuses.list) do
  f:read()
  f:purge()
  -- print(i..": category='"..f.file_category.."', fusename='"..f.file_fusename.."'")
  f:print()
end



os.exit(0)



function createSingleInstallers()
  print("createSingleInstallers")
  ui.ExitLoop()
end





ui.chooseInstallOption({
    targetIsGitRepo = bmd.fileexists(user_config.pathToRepository..'.git'  ),
    onSingleInstallersSelected = createSingleInstallers,
  })





ui.RunLoop()
os.exit(0)



local PATH_TO_REPOSITORY='/Users/nmbr73/Projects/Shadertoys'


if PATH_TO_REPOSITORY==nil or PATH_TO_REPOSITORY=='' then
  PATH_TO_REPOSITORY=getOwnPath()..'../'
  if not(directoryExists(PATH_TO_REPOSITORY,".git")) then
    PATH_TO_REPOSITORY=nil
    print("repo not found")
    os.exit(10)
  end
end



fuse=Fuse:new(PATH_TO_REPOSITORY..'/Shaders/Abstract/CrossDistance.fuse')

print("a: Cat: '"..fuse.file_category.."', Fuse: '"..fuse.file_fusename.."'")
