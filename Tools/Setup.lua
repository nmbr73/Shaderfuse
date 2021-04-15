--[[

  Integrate the repository Tools into the Script menu
  Use Fuses under Shaders straight out of the repository
  Make Atom Fuses available to test them

]]





local icon            = nil
local repositorypath  = nil
local usrcfg_filename = nil
local paths           = {}
local exists          = {}
local checked         = {}
local ui              = fu.UIManager
local ui_dispatcher   = bmd.UIDispatcher(ui)




function init()

  local pathseparator     = package.config:sub(1,1)
  local fusepath          = fusion:MapPath("Fuses:/")
        repositorypath    = debug.getinfo(2, "S").source:sub(2):match("(.*[/\\])Tools[/\\]")

  icon=assert(loadfile(repositorypath.."Tools/Modules/Lua/Shadertoys/icon.lua"))()

  assert(bmd.direxists(repositorypath..'.git/'))

  paths.bmddir_mods= fusion:MapPath("LuaModules:/")..'Shadertoys'
  paths.bmddir_comp= fusion:MapPath("Scripts:/")..'Comp'..pathseparator..'Shadertoys'
  paths.gitdir_mods= repositorypath.. ('Tools/Modules/Lua/Shadertoys'):gsub('/',pathseparator)
  paths.gitdir_comp= repositorypath.. ('Tools/Scripts/Comp/Shadertoys'):gsub('/',pathseparator)
  paths.bmddir_atom= fusepath.. 'Shadertoys_wsl'
  paths.gitdir_atom= repositorypath.. ('Atom/com.JiPi.Shadertoys/Fuses/Shadertoys_wsl/'):gsub('/',pathseparator)
  paths.bmddir_fuse= fusepath.. 'Shadertoys_dev'
  paths.gitdir_fuse= repositorypath.. ('Shaders/'):gsub('/',pathseparator)

  usrcfg_filename  = repositorypath.. ('Tools/Modules/Lua/Shadertoys/'):gsub('/',pathseparator)..'~user_config.lua'

  for key, path in pairs(paths) do
    exists[key]  = bmd.direxists(path)
  end

  assert( exists['bmddir_comp'] ==  exists['bmddir_mods'] )

  for i, key in ipairs( {'bmddir_mods', 'bmddir_comp', 'bmddir_atom', 'bmddir_fuse', }) do
    checked[key]  = exists[key]
  end

end


function config_changed()
  return   checked.bmddir_comp ~= exists.bmddir_comp
        or checked.bmddir_fuse ~= exists.bmddir_fuse
        or checked.bmddir_atom ~= exists.bmddir_atom
end



function cmd_ln(target_folder,link_name)

  if FuPLATFORM_MAC then
    os.execute("ln -s '"..target_folder.."' '"..link_name.."'")
  elseif FuPLATFORM_WINDOWS then
    os.execute("mklink /D '"..link_name.."' '"..target_folder.."'")
  else
    assert(false)
  end

end



function cmd_rm(link_name)

  if FuPLATFORM_MAC or FuPLATFORM_LINUX then
    os.execute("rm '"..link_name.."'")
  elseif FuPLATFORM_WINDOWS then
    os.execute("rmdir '"..link_name.."'")
  else
    assert(false)
  end

end



function setup()

  assert(FuPLATFORM_MAC) -- not tested on windows!

  assert( checked['bmddir_comp'] == checked['bmddir_mods'] )

  for i, key in ipairs( {'mods', 'comp', 'atom', 'fuse', }) do
    if checked['bmddir_'..key] == true and exists['bmddir_'..key] == false then
        -- install
        cmd_ln( paths['gitdir_'..key], paths['bmddir_'..key] )
    elseif checked['bmddir_'..key] == false and exists['bmddir_'..key] == true then
        -- uninstall
       cmd_rm( paths['bmddir_'..key] )
    end
  end

end



function usrcfg_dialog()

  local win = ui_dispatcher:AddWindow({

    ID = "Dialog",
    WindowTitle = "Shadertoys Setup",
    Geometry = { 100, 100, 500, 180 },

    ui:VGroup {

      ui:VGap(5),

      ui:HGroup {

        ui:HGap(5),

        icon.label(ui),

        ui:HGap(10),

        ui:Label {
          Weight = 1,
          Alignment = { AlignHCenter = false, AlignVTop = false, },
          WordWrap = false,
          Text = [[<font color="white"><strong>Create user config file?</strong></font>
            <p>There is no user config file in your git repository.<br />
            This file is needed to store some individual configuration.<br />
            In particular it is a prerequisite for this setup to work properly.<br />
            Okay for you to let this script create the user config file?</p>
            ]],
        },

        ui:HGap(5),

      },

      ui:VGap(0,1),

      ui:HGroup {
        Weight = 0,
        ui:HGap(0,1),
        ui:Button{ ID = "Okay",   Text = "Okay"   },
        ui:HGap(5),
        ui:Button{ ID = "Cancel",   Text = "Cancel" },
        ui:HGap(5),
      }
    }
  })



  function win.On.Okay.Clicked(ev)
    win:Hide()

    local f = io.open(usrcfg_filename,"wb")

    assert(f)

    if f then
      f:write([[
        local user_config = { pathToRepository = ']]..repositorypath..[[' }
        return user_config
      ]])
      f:close()
    end

    setup_dialog()
  end


  function win.On.Cancel.Clicked(ev)
    ui_dispatcher:ExitLoop()
  end


  function win.On.Dialog.Close(ev)
    ui_dispatcher:ExitLoop()
  end


  win:Show()
end




function setup_dialog()


  local win = ui_dispatcher:AddWindow({

    ID = "Dialog",
    WindowTitle = "Shadertoys Setup",
    Geometry = { 100, 100, 500, 160 },

    ui:VGroup {

      ui:VGap(5),

      ui:HGroup {

        ui:HGap(5),

        icon.label(ui),

        ui:HGap(10),

        ui:VGroup {
          Weight=0,
          ui:CheckBox{ID = 'Tools',   Text = "Integrate the repository Tools into Script menu",           Checked=checked.bmddir_comp,  Enabled=exists.gitdir_comp and exists.gitdir_mods, },
          ui:CheckBox{ID = 'Fuse',    Text = "Use Fuses under Shaders straight out of the repository",    Checked=checked.bmddir_fuse,  Enabled=exists.gitdir_fuse,  },
          ui:CheckBox{ID = 'Atom',    Text = "Make Atom Fuses available to test them",                    Checked=checked.bmddir_atom,  Enabled=exists.gitdir_atom,   },
        },

        ui:HGap(5),

      },

      ui:VGap(0,1),

      ui:HGroup {
        Weight = 0,
        ui:HGap(0,1),
        ui:Button{ ID = "Save",     Text = "Save", Enabled = false     },
        ui:HGap(5),
        ui:Button{ ID = "Cancel",   Text = "Cancel" },
        ui:HGap(5),
      }
    }
  })



  local itm = win:GetItems()


  function win.On.Tools.Clicked(ev)
    checked.bmddir_comp=ev.On
    checked.bmddir_mods=checked.bmddir_comp
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
    restart_dialog()
    -- ui_dispatcher:ExitLoop()
  end


  function win.On.Cancel.Clicked(ev)
    ui_dispatcher:ExitLoop()
  end


  function win.On.Dialog.Close(ev)
    ui_dispatcher:ExitLoop()
  end


  win:Show()
end



function restart_dialog()

  local win = ui_dispatcher:AddWindow({

    ID = "Dialog",
    WindowTitle = "Shadertoys Setup",
    Geometry = { 100, 100, 500, 150 },

    ui:VGroup {

      ui:VGap(5),

      ui:HGroup {

        ui:HGap(5),

        icon.label(ui),

        ui:HGap(10),

        ui:Label {
          Weight = 1,
          Alignment = { AlignHCenter = false, AlignVTop = false, },
          WordWrap = false,
          Text = [[<font color="white"><strong>Restart the application!</strong></font>
            <p>
              For the applied changes to take effect, but in particular for<br />
              the application to run properly, please quit and reopen!
            </p>
            ]],
        },

        ui:HGap(5),

      },

      ui:VGap(0,1),

      ui:HGroup {
        Weight =0 ,
        ui:HGap(0,1),
        ui:Button{ ID = "Okay",   Text = "Okay"   },
        ui:HGap(0,1),
      }
    }
  })

  function win.On.Okay.Clicked(ev)
    ui_dispatcher:ExitLoop()
  end


  function win.On.Dialog.Close(ev)
    ui_dispatcher:ExitLoop()
  end

  win:Show()
end


init()

if bmd.fileexists(usrcfg_filename) then
  setup_dialog()
else
  usrcfg_dialog()
end

ui_dispatcher:RunLoop()
