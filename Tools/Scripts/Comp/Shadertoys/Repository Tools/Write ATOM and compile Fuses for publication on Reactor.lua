
require("string")
require("Shadertoys/function_writeAtom")

local simpleDialog = require("Shadertoys/simpleDialog")
local ui_manager    = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui_manager)

simpleDialog.window(
    ui_manager,
    ui_dispatcher,
    {
      windowTitle="Refresh Atom package for Reactor",
      -- onOkay=do_update,

      onOkay= function()
        writeAtom()

        print("Atom updated")
        ui_dispatcher:ExitLoop()
      end,

      text=
      [[<p>By clicking 'okay' all the files in in the 'Atom/' will be rewritten.
      For a fresh install you should consider to delete that folders content first.
      </p>
            ]]
    }):Show()


ui_dispatcher:RunLoop()
