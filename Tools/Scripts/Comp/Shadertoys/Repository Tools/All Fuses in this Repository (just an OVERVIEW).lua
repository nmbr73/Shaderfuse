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



selectFusesDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      fuses=fuses,
      windowTitle='Fuses in this Repositoy (dbl click for details)',
      -- onInstall=createSingleInstallers,
      cancelLabel='OK',
      logo=image.logo_label(ui_manager),
    }):Show()


ui_dispatcher:RunLoop()
