require("string")
require("Shaderfuse/maintenance_functions")

local simpleDialog = require("Shaderfuse/simpleDialog")
local ui_manager    = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui_manager)

simpleDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      windowTitle="Refresh the Fuses' MarkDown files",
      -- onOkay=do_update,

      onOkay= function()
        create_markdown_files()
        print("Markdown updated")
        ui_dispatcher:ExitLoop()
      end,

      text=
      [[<p>By clicking 'okay' all README.md files in the 'docs/' folder and all its subdirectories will be rewritten.
      Also the 'docs/OVERVIEW.md' files will be recreated.
      </p>
      <p>
      DOES NOT WORK AT THE MOMENT !!!
      </p>
            ]]
    }):Show()


ui_dispatcher:RunLoop()
