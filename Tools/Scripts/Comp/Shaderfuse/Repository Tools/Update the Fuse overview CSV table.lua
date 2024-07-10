require("string")
require("Shaderfuse/maintenance_functions")

local simpleDialog = require("Shaderfuse/simpleDialog")
local ui_manager    = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui_manager)

simpleDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      windowTitle="Refresh the Fuse CSV table",
      -- onOkay=do_update,

      onOkay= function()
        create_csv()
        print("CSV updated")
        ui_dispatcher:ExitLoop()
      end,

      text=
      [[<p>'okay' rewrites the Shaders.csv file in your working copy.
      </p>
            ]]
    }):Show()


ui_dispatcher:RunLoop()
