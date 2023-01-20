local selectFusesDialog={}

function selectFusesDialog.window(ui,dispatcher,params)

  assert(params~=nil)
  assert(params.fuses~=nil)

  local thumbWidth=107 -- 160
  local thumbHeight=60 -- 90

  local win = dispatcher:AddWindow({

    ID = "ShaderInstallMain",
    WindowTitle = params.windowTitle,
    Geometry = { 100, 100, 800, 400 },

    ui:VGroup {

      ui:HGroup {
        Weight = 0,
        -- ui.logo(),

        params.logo,

        ui:HGap(0,1),

        ui:Label{
          Weight = 0,
          ID = "Thumbnail",
          MinimumSize = {thumbWidth, thumbHeight},
          Alignment = { AlignHCenter = false, AlignTop = true, },
          WordWrap = false, ReadOnly = true, Flat = true, Text = '',

        },
      },


      ui:VGap(5),


      ui:Tree {
        ID = 'Files',
        Weight = 2,
        MinimumSize = {600, 200},
        SortingEnabled=true, -- UpdatesEnabled=true,
        Events = { ItemDoubleClicked=true, CurrentItemChanged = true, }, -- ItemActivated=true, ItemClicked=true,
      },


      ui:VGap(5),

      ui:HGroup{
        Weight = 0,

        ui:Label {
          ID = 'Info',
          Weight = 3.0,
          Alignment = { AlignHCenter = false, AlignVTop = true, },
          WordWrap = false,
        },

        ui:HGap(0,1),
        ui:Button{ ID = "Install",  Text = (params.installLabel and  params.installLabel or "Install"), Hidden = (params.onInstall == nil and true or false) },
        ui:Button{ ID = "Cancel",   Text = (params.cancelLabel and  params.cancelLabel or "Cancel") },
      },

    },
  })


  local itm = win:GetItems()


  function win.On.Install.Clicked(ev)
    win:Hide()
    params.onInstall(params.fuses)
  end


  function win.On.Cancel.Clicked(ev)
    win:Hide()
    dispatcher:ExitLoop()
  end


  function win.On.ShaderInstallMain.Close(ev)
    win:Hide()
    dispatcher:ExitLoop()
  end

  function win.On.Files.ItemDoubleClicked(ev)
    local fuse=params.fuses.get_fuse(ev.item.Text[0],ev.item.Text[1])

    if fuse~=nil then
      bmd.openurl('https://nmbr73.github.io/Shadertoys/Shaders/'..fuse.Category..'/'..fuse.Name..'.html')
    end
  end

  local defaultInfoText=""

  function win.On.Files.CurrentItemChanged(ev)

    local fuse=params.fuses.get_fuse(ev.item.Text[0],ev.item.Text[1])

    if fuse==nil then return end

    if fuse.hasThumbnail then
      itm.Thumbnail.Text='<img src="' .. fuse.DirName .. '/' .. fuse.Name .. '.png" width="'..thumbWidth..'" height="'..thumbHeight..'" />'
    else
      itm.Thumbnail.Text=''
    end

    itm.Info.Text = fuse:hasErrors() and '<span style="color:#ff9090; ">'..fuse:getErrorText().."</span>" or defaultInfoText
  end



  local hdr = itm.Files:NewItem()

  hdr.Text[0] = 'Category'
  hdr.Text[1] = 'Fuse Name'
  hdr.Text[2] = 'Author'
  hdr.Text[3] = 'Port'
  hdr.Text[4] = 'Status'

  itm.Files:SetHeaderItem(hdr)
  itm.Files.ColumnCount = 5

  itm.Files.ColumnWidth[0] = 160
  itm.Files.ColumnWidth[1] = 380
  itm.Files.ColumnWidth[2] = 100
  itm.Files.ColumnWidth[3] = 60
  itm.Files.ColumnWidth[4] = 60

  local numFuses=0

  for _, f in ipairs(params.fuses.list) do

    local newitem = itm.Files:NewItem()

    newitem.Text[0] = f.Category
    newitem.Text[1] = f.Name
    newitem.Text[2] = f.Shadertoy.Author
    newitem.Text[3] = f.Author
    newitem.Text[4] = (f:hasErrors() and '   🚫' or '   ✔︎')

    itm.Files:AddTopLevelItem(newitem)

    if f.error==nil then
      numFuses=numFuses+1
    end
  end

  itm.Files:SortByColumn(1, "AscendingOrder")
  itm.Files:SortByColumn(0, "AscendingOrder")

  defaultInfoText = numFuses.." valid fuses found"

  return win

end



return selectFusesDialog
