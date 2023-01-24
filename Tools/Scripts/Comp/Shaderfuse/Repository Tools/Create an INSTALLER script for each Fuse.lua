require("string")

require("Shaderfuse/function_createInstaller")

local simpleDialog = require("Shaderfuse/simpleDialog")
local ui_manager    = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui_manager)

simpleDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      windowTitle="Refresh the Fuses' Installer scripts",
      -- onOkay=do_update,

      onOkay= function()
        createInstallers()
        print("Installers created")
        ui_dispatcher:ExitLoop()
      end,

      text= [[<p>By clicking 'okay' all *-Installer.lua files in the 'build/' folder and all its subdirectories will be rewritten.</p>]]

    }):Show()


ui_dispatcher:RunLoop()
