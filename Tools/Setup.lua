--[[

  Integrate the repository Tools into the Script menu
  Use Fuses under Shaders straight out of the repository
  Make Atom Fuses available to test them

]]

local ui            = fu.UIManager
local ui_dispatcher = bmd.UIDispatcher(ui)


local paths     = {}
local exists    = {}
local checked   = {}

function config_changed()
  return   checked.bmddir_tools~= exists.bmddir_tools
        or checked.bmddir_fuse ~= exists.bmddir_fuse
        or checked.bmddir_atom ~= exists.bmddir_atom
end


function do_install(k)
  return checked['bmddir_'..k] == true and exists['bmddir_'..k] == false
end

function do_uninstall(k)
  return checked['bmddir_'..k] == false and exists['bmddir_'..k] == true
end

function cmd_ln(target_folder,link_name)

  if FuPLATFORM_MAC then
    os.execute("ln -s '"..target_folder.."' '"..link_name.."'")
  end

  assert(false)
end

function cmd_rm(link_name)

  if FuPLATFORM_MAC then
    os.execute("rm '"..link_name.."'")
  end

  assert(false)
end



function setup()


  assert(FuPLATFORM_MAC)

  -- https://www.giga.de/downloads/windows-10/tipps/symlinks-in-windows-erstellen-mit-mklink-so-gehts/
  -- https://www.pcwelt.de/tipps/Profi-Wissen-Hardlinks-Symlinks-und-Softlinks-Windows-und-Software-496098.html
  -- https://krausens-online.de/hard-softlinks-teil-1-theorie-laaaangweilig/
  -- windows:
  -- mklink 'LINK' 'TARGET'
  -- /D softlink to folder
  -- /J softlink to folder
  -- rmdir ... to remove


  if do_install('tools') then
    cmd_ln( paths.gitdir_comp, paths.bmddir_comp )
    cmd_ln( paths.gitdir_mods, paths.bmddir_mods )
  elseif do_uninstall('tools') then
    cmd_rm( paths.bmddir_comp )
    cmd_rm( paths.bmddir_mods )
  end

  if do_install('fuse') then
    cmd_ln( paths.gitdir_fuse, paths.bmddir_fuse )
  elseif do_uninstall('fuse') then
    cmd_rm( paths.bmddir_fuse )
  end

  if do_install('atom') then
    cmd_ln( paths.gitdir_atom, paths.bmddir_atom )
  elseif do_uninstall('atom') then
    cmd_rm( paths.bmddir_atom )
  end


end


function dialog()

  local win = ui_dispatcher:AddWindow({

    ID = "Dialog",
    WindowTitle = "Shadertoys Megalinkomania",
    Geometry = { 100, 100, 400, 200 },

    ui:VGroup {

      Weight=1,

      ui:VGap(0,1),

      ui:VGroup {
        Weight=0,
        ui:CheckBox{ID = 'Tools',   Text = "Integrate the repository Tools into Script menu",           Checked=checked.bmddir_tools, Enabled=exists.gitdir_tools, },
        ui:CheckBox{ID = 'Fuse',    Text = "Use Fuses under Shaders straight out of the repository",    Checked=checked.bmddir_fuse,  Enabled=exists.gitdir_fuse,  },
        ui:CheckBox{ID = 'Atom',    Text = "Make Atom Fuses available to test them",                    Checked=checked.bmddir_atom,  Enabled=exists.gitdir_atom,   },
      },

      ui:VGap(5),

      ui:Label {
        Weight = 0,
        Alignment = { AlignHCenter = false, AlignVTop = flase, },
        WordWrap = false,
        Text = '<font color="#ff9090">Use at your own risk ...</font>',
      },

      ui:VGap(0,1),

      ui:HGroup {
        Weight = 0,
        ui:HGap(0,1),
        ui:Button{ ID = "Save",     Text = "Save", Enabled = false   },
        ui:HGap(5),
        ui:Button{ ID = "Cancel",   Text = "Cancel" },
      },
    },
  })


  local itm = win:GetItems()


  function win.On.Tools.Clicked(ev)
    checked.bmddir_tools=ev.On
    itm.Save.Enabled = config_changed()
  end


  function win.On.Fuse.Clicked(ev)
    checked.bmddir_fuse=ev.On
    itm.Save.Enabled = config_changed()
  end


  function win.On.Atom.Clicked(ev)
    checked.bmddir_atom=ev.On
    itm.Save.Enabled = config_changed()
  end


  function win.On.Save.Clicked(ev)
    win:Hide()
    setup()
    ui_dispatcher:ExitLoop()
  end


  function win.On.Cancel.Clicked(ev)
    ui_dispatcher:ExitLoop()
  end


  function win.On.ShaderInstallMain.Close(ev)
    ui_dispatcher:ExitLoop()
  end


  win:Show()
end






function init()

  local pathseparator     = package.config:sub(1,1)
  local repositorypath    = debug.getinfo(2, "S").source:sub(2):match("(.*[/\\])Tools[/\\]")
  local fusepath          = fusion:MapPath("Fuses:/")

  assert(bmd.direxists(repositorypath..'.git/'))

  paths.bmddir_mods= fusion:MapPath("LuaModules:/")..'Shadertoys'
  paths.bmddir_comp= fusion:MapPath("Scripts:/")..'Comp'..pathseparator..'Shadertoys'
  paths.gitdir_mods= repositorypath.. ('Tools/Modules/Lua/Shadertoys'):gsub('/',pathseparator)
  paths.gitdir_comp= repositorypath.. ('Tools/Scripts/Comp/Shadertoys'):gsub('/',pathseparator)
  paths.bmddir_atom= fusepath.. 'Shadertoys_wsl'
  paths.gitdir_atom= repositorypath.. ('Atom/com.JiPi.Shadertoys/Fuses/Shadertoys_wsl/'):gsub('/',pathseparator)
  paths.bmddir_fuse= fusepath.. 'Shadertoys_dev'
  paths.gitdir_fuse= repositorypath.. ('Shaders/'):gsub('/',pathseparator)


  for key, path in pairs(paths) do
    exists[key]  = bmd.direxists(path)
  end

  for i, key in ipairs( {'bmddir_mods', 'bmddir_comp', 'bmddir_atom', 'bmddir_fuse', }) do
    checked[key]  = exists[key]
  end


  exists['bmddir_tools']         = exists.bmddir_mods and exists.bmddir_comp
  checked['bmddir_tools']        = exists.bmddir_tools
  exists['gitdir_tools']         = exists.gitdir_mods and exists.gitdir_comp

end



init()
dialog()

ui_dispatcher:RunLoop()
