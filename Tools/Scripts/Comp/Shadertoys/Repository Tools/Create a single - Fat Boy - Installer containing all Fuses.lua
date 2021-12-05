require("string")

local user_config = require("Shadertoys/~user_config")
local fuses       = require("Shadertoys/fuses")
local image       = require("Shadertoys/image")
local selectFusesDialog = require("Shadertoys/selectFusesDialog")

-- print("sep '"..util.path_separator.."'")
-- print("path '".. user_config.pathToRepository .."'")
-- local targetIsGitRepo = bmd.fileexists(user_config.pathToRepository..'.git')


local ui_manager    = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui_manager)


fuses.fetch(user_config.pathToRepository..'Shaders/',true)


function createFatty(fuses)
  print("create a single installer - one containing all fuses")
  ui_dispatcher:ExitLoop()
end

selectFusesDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      fuses=fuses,
      windowTitle='Create one Installer containing all Fuses',
      onInstall=createFatty,
      logo=image.logo_label(ui_manager),
    }):Show()


ui_dispatcher:RunLoop()
