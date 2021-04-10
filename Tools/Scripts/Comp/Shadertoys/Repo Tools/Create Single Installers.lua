require("string")

local user_config = require("Shadertoys/~user_config")
local fuses       = require("Shadertoys/fuses")
local util        = require("Shadertoys/util")
local ui          = require("Shadertoys/ui")

print("sep '"..util.path_separator.."'")
print("path '".. user_config.pathToRepository .."'")


local targetIsGitRepo = bmd.fileexists(user_config.pathToRepository..'.git')

fuses.fetch(user_config.pathToRepository..'Shaders/',true)


function createSingleInstallers(fuses)
  print("create single installsers")
  ui.ExitLoop()
end



ui.selectFusesDialog({
      fuses=fuses,
      windowTitle='Create Single Installers',
      onInstall=createSingleInstallers
    }):Show()


ui.RunLoop()
