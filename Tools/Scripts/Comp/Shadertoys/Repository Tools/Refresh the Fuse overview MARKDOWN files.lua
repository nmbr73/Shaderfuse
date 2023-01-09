require("string")

require("Shadertoys/function_updateMarkdown")

local simpleDialog = require("Shadertoys/simpleDialog")
local ui_manager    = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui_manager)

simpleDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      windowTitle="Refresh the Fuses' MarkDown files",
      -- onOkay=do_update,

      onOkay= function()
        updateMarkdown()
        print("Markdown updated")
        ui_dispatcher:ExitLoop()
      end,

      text=
      [[<p>By clicking 'okay' all README.md files in the 'Shaders/' folder and all its subdirectories will be rewritten.
      Also the 'Shaders/OVERVIEW.md' file will be recreated.
      </p>
            ]]
    }):Show()


ui_dispatcher:RunLoop()
