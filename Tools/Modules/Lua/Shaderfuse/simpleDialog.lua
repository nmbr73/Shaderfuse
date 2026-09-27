local simpleDialog = {}

local image = require("Shaderfuse/image")


------------------------------------------------------------------------------
-- Create a simple dialog window with Okay and Cancel buttons
--
-- @param ui The Fusion UI manager
-- @param dispatcher The UI dispatcher
-- @param params Table with window configuration:
--   - windowTitle: Window title
--   - text: Text to display
--   - onOkay: Function to call when Okay is clicked
--   - okayLabel: Custom label for Okay button (default: "Okay")
--   - cancelLabel: Custom label for Cancel button (default: "Cancel")
-- @return The window object

function simpleDialog.window(ui, dispatcher, params)
  assert(params ~= nil)

  local win = dispatcher:AddWindow({
    ID = "Dialog",
    WindowTitle = params.windowTitle,
    Geometry = { 100, 100, 500, 160 },

    ui:VGroup {
      ui:VGap(5),

      ui:HGroup {
        ui:HGap(5),
        image.icon_label(ui),
        ui:HGap(10),

        ui:Label {
          Weight = 1,
          Alignment = { AlignHCenter = false, AlignVTop = false },
          WordWrap = true,
          Text = params.text,
        },

        ui:HGap(5),
      },

      ui:HGroup {
        Weight = 0,
        ui:HGap(0, 1),
        ui:Button {
          ID = "Okay",
          Text = params.okayLabel or "Okay",
          Hidden = params.onOkay == nil
        },
        ui:HGap(5),
        ui:Button {
          ID = "Cancel",
          Text = params.cancelLabel or "Cancel"
        },
        ui:HGap(5),
      },
    },
  })

  function win.On.Okay.Clicked(ev)
    win:Hide()
    if params.onOkay then params.onOkay() end
  end

  function win.On.Cancel.Clicked(ev)
    win:Hide()
    dispatcher:ExitLoop()
  end

  function win.On.Dialog.Close(ev)
    win:Hide()
    dispatcher:ExitLoop()
  end

  return win
end




return simpleDialog
