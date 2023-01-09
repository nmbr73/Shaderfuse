local simpleDialog={}

local image           = require("Shadertoys/image")


function simpleDialog.window(ui,dispatcher,params)

  assert(params~=nil)

  local thumbWidth=107 -- 160
  local thumbHeight=60 -- 90

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
          Alignment = { AlignHCenter = false, AlignVTop = false, },
          WordWrap = true,
          Text = params.text,
        },

        ui:HGap(5),

      },

      -- ui:VGap(0,1),


      ui:HGroup{
        Weight = 0,

        ui:HGap(0,1),
        ui:Button{ ID = "Okay",  Text = (params.okayLabel and  params.okayLabel or "Okay"), Hidden = (params.onOkay == nil and true or false) },
        ui:HGap(5),
        ui:Button{ ID = "Cancel",   Text = (params.cancelLabel and  params.cancelLabel or "Cancel") },
        ui:HGap(5),
      },

    },


  })


  local itm = win:GetItems()


  function win.On.Okay.Clicked(ev)
    win:Hide()
    params.onOkay()
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
