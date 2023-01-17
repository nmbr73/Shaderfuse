require("string")

local g_ui                = fu.UIManager
local g_disp              = bmd.UIDispatcher(g_ui)
local g_wingeometry       = { 100, 100, 800, 400 }

local TARGET_FUSES_SUBDIRECTORY = "Shadertoys"
-- local TARGET_FUSES_SUBDIRECTORY="DarthShader"



local g_chosenInstallModeOption              = nil
local g_messageBoxWindow         = nil
local g_useShortcutPrefix = nil
local g_useShadertoyID = nil
local g_useCategoryPathes = nil



-- ----------------------------------------------------------------------



function base64_decode(data)
  local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  data = string.gsub(data, '[^'..b..'=]', '')
  return (data:gsub('.', function(x)
    if (x == '=') then return '' end
    local r,f='',(b:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then return '' end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end



function base64_encode(data)
  local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  return ((data:gsub('.', function(x)
    local r,b='',x:byte()
    for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
    return r;
  end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
    if (#x < 6) then return '' end
    local c=0
    for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
    return b:sub(c+1,c+1)
  end)..({ '', '==', '=' })[#data%3+1])
end



function printERR(message)

  -- Just because I have no clue how to print to stderr in a way that the
  -- Resolve colsole shows it.

  if message~=nil then
		print("ERR " .. message)
	end
end



-- ----------------------------------------------------------------------
-- INSTALL MODES
-- ----------------------------------------------------------------------

function initInstallModeOptions(params)


  assert(g_chosenInstallModeOption == nil)
  assert(params ~= nil)
  assert(params.TargetIsGitRepo ~= nil)


  local localCopyTextAdd  = ''
  local localCopyEnabled  = true

  if params.TargetIsGitRepo then

    localCopyEnabled = false
    localCopyTextAdd = [[
            <p style="color:#ff9090; ">
            This option is not available ...
            </p>
            <p style="color:#ffffff; ">
              It seems that you are managing our Shadertoy Fuses using Git already. That's awesome! Forking and/or cloning us
              on GitHub obviously is the right and more pro way of doing things. Just use a 'git pull' in your 'Shadertoys'
              directory and you are up to date and good to go. Looking forward to your pull requests maybe contributing some
              beatutiful shaderstoys?!!
            </p>
            ]]
  end

  local options=
  {
    { -- Mode        = MODE_NONE,
      Label       = "- chose installation mode -",
      Enabled     = false,
      Procedure   = doNothing,
      Text        = "<p>This script is menat to install the shader fuses, or to create installation scripts to install the shader fuses. Use the select box on top to chose an installation mode and to see further details on the respective method.</p>",
    },

    { -- Mode        = MODE_LOCALCOPY,
      Label       = "Local Copy",
      Enabled     = localCopyEnabled,
      Procedure   = doLocalCopy,
      Text        = "<p>If you have downloaded and extracted(!) the whole repository as a ZIP file, then this mode should help you to create a local copy of the fuses in the correct target directory. In this case the script creates the <em>Shadertoys<em> subdirectories in your DaVinci Resolve's / Fusion's <em>Fuses</em> directory and copies all the .fuse files and only these to that directory.</p>"
                      ..localCopyTextAdd,
    },

    { -- Mode        = MODE_SINGLEINSTALLERS,
      Label       = "Single Installers",
      Enabled     = true,
      Procedure   = doSingleInstallers,
      Text        = "<p>This options generates a separate installer script for each fuse. These scripts can be used to share single Fuses separated from the repository with others, but still providing the convenience of not having to copy the Fuse to the specific pathes manually. Just drag and drop such an installer script onto your Fusion's working area and the script will guide you through the installation.</p>",
    },

    { -- Mode        = MODE_CREATEINSTALLER,
      Label       = "Create Installer",
      Enabled     = false,
      Procedure   = doCreateInstaller,
      Text        = "<p>The 'Create Installer' is to create a single Lua script that can be used to install all the fuses. It is intended to be provided in particular as a separate download with no need to copy the ZIP or clone the repository.</p>"
                      .."<p style=\"color:#ff9090; \">This option hasn't been implemented yet!</p>",
    },

    { -- Mode        = MODE_PREPARESUGGESTION,
      Label       = "Prepare WSL Suggestion",
      Enabled     = false,
      Procedure   = doPrepareSuggestion,
      Text        = "<p>Idea is to have the installer create copies of the Fuses without all the prefixes, debug settings, additinal files, etc. This to end up with a directory structure that can be used in preparation of a suggestion for integration into the WSL Reactor.</p>"
                      .."<p style=\"color:#ff9090; \">This option hasn't been implemented yet!</p>",
    },
  }

  g_chosenInstallModeOption = options[1]

  return options
end



-- ----------------------------------------------------------------------
-- WINDOW TO JUST SHOW A SIMPLE MESSAGE
-- ----------------------------------------------------------------------

function showMessageBoxWindow(str)

  assert(str~=nil)

  if g_messageBoxWindow==nil then

    g_messageBoxWindow = g_disp:AddWindow({
      ID = "ShaderMessageBox",
      WindowTitle = "Shadertoys Installer - Message",
      Geometry = { 150,150,400,200 },
      -- Composition = comp,
      g_ui:VGroup {
        -- ID = "root",

        g_ui:Label{
          ID = "Message",
          WordWrap = true,
          Weight = 1,
          ReadOnly = true,
          Flat = true,
          Alignment = { AlignHCenter = false, AlignTop = true, },
          Text = ""
        },

        g_ui:HGroup {
          Weight = 0,
          g_ui:HGap(0,1),
          g_ui:Button{ ID = "Close", Text = "Okay" },
          g_ui:HGap(0,1),
        },
      },
    })

    function g_messageBoxWindow.On.Close.Clicked(ev)
      printERR("msgbox close clicked - ExitLoop")
      g_disp:ExitLoop()
    end

    function g_messageBoxWindow.On.ShaderMessageBox.Close(ev)
      printERR("msgbox window closed - ExitLoop")
      g_disp:ExitLoop()
    end

  end

  if str~=nil then
    local itm = g_messageBoxWindow:GetItems()
    itm.Message.Text = str
  end

  g_messageBoxWindow:Show()
end



-- ----------------------------------------------------------------------
-- WINDOWN TO SELECT THE INSTALLATION PROCEDURE
-- ----------------------------------------------------------------------

function initInstallSelectWindow(params)

  assert(params~=nil)
  assert(params.InstallModeOptions~=nil)
  assert(params.NextWindow~=nil)

  local win = g_disp:AddWindow({

    ID = "ShaderInstallSelect",
    WindowTitle = "Shadertoys Installer - Select Installation mode ...",
    Geometry = g_wingeometry,
    -- Composition = comp,

    g_ui:VGroup {
      -- ID = "root",
      Weight=1,

      logo(),

      g_ui:VGap(10),

      g_ui:ComboBox{
        ID = "ModeSelection",
        Text = 'Install Mode Selection',
        Weight = 0,
        Events = { CurrentIndexChanged = true, Activated = true },
        Items = { 'Foo' , 'Bar'},
      },

      g_ui:VGap(10),

      g_ui:Label{
        ID = "Description",
        WordWrap = true,
        Weight = 1,
        ReadOnly = true,
        Flat = true,
        Alignment = { AlignHCenter = false, AlignTop = true, },
        Text = ""
      },

      g_ui:HGroup {
        Weight = 0,
        g_ui:HGap(0,1),
        g_ui:Button{ ID = "Continue",   Text = "Continue ..." },
        g_ui:HGap(5),
        g_ui:Button{ ID = "Cancel",   Text = "Cancel" },
      },
    },
  })


  local itm=win:GetItems()

  for i=1, 5 do
    itm.ModeSelection:AddItem(params.InstallModeOptions[i].Label)
  end


  function win.On.ModeSelection.CurrentIndexChanged(ev)

    local index = itm.ModeSelection.CurrentIndex+1
    local entry = params.InstallModeOptions[index]

    assert(entry ~= nil)

    g_chosenInstallModeOption=entry
    itm.Continue.Enabled=entry.Enabled
    itm.Description.Text=entry.Text
  end


  function win.On.Continue.Clicked(ev)
    win:Hide()
    --showInstallMainWindow()
    params.NextWindow:Show()
  end


  function win.On.Cancel.Clicked(ev)
    g_disp:ExitLoop()
    os.exit()
  end


  function win.On.ShaderInstallSelect.Close(ev)
    g_disp:ExitLoop()
    os.exit()
  end

  return win

end



-- ----------------------------------------------------------------------
-- MAIN WINDOW
-- ----------------------------------------------------------------------

function initMainWindow(params)

  assert(params~=nil)
  assert(params.InstallModeOptions~=nil)
  assert(params.ListOfFuses~=nil)

  local win = g_disp:AddWindow({

    ID = "ShaderInstallMain",
    WindowTitle = "Shadertoys Installer",
    Geometry = g_wingeometry,
    -- Composition = comp,

    g_ui:VGroup {
      -- ID = "root",

      g_ui:HGroup {
        Weight = 0,
        logo(),
      },

      g_ui:VGap(5),

      g_ui:Tree {
        ID = 'Files',
        Weight = 2,
        SortingEnabled=true,
        Events = {  ItemDoubleClicked=true, ItemClicked=true },
      },

      g_ui:VGap(5),

      g_ui:VGroup {
          Weight = 0,
          g_ui:CheckBox{ID = 'UseShortcutPrefix', Text = "Use prefix not only for Fuse name, but also for its OpIconString",  Checked=false },
          g_ui:CheckBox{ID = 'UseShadertoyID',    Text = "Use Shadertoy IDs as Identifiers instead of shortcuts ",            Checked=true  },
          g_ui:CheckBox{ID = 'UseCategoryPathes', Text = "Use pathes as categrory for 'Add Tool ...' menu",                   Checked=true  },
      },

      g_ui:VGap(5),

      g_ui:HGroup{
        Weight = 0,

        g_ui:Label {
          ID = 'NumberOfFusesLabel',
          Weight = 3.0,
          Alignment = { AlignHCenter = false, AlignVTop = true, },
          WordWrap = false,
        },

        g_ui:HGap(0,1),
        g_ui:Button{ ID = "Install", Text = "Install" },
        g_ui:Button{ ID = "Cancel", Text = "Cancel" },
      },

    },
  })


  function win.On.Install.Clicked(ev)

    assert(g_chosenInstallModeOption ~= nil)

    win:Hide()
    g_chosenInstallModeOption.Procedure(params.ListOfFuses)
  end


  function win.On.Cancel.Clicked(ev)
    g_disp:ExitLoop()
    os.exit()
  end


  function win.On.ShaderInstallMain.Close(ev)
    g_disp:ExitLoop()
    os.exit()
  end


  local itm = win:GetItems()
  local hdr = itm.Files:NewItem()
  hdr.Text[0] = 'Fuse Name'
  itm.Files:SetHeaderItem(hdr)
  itm.Files.ColumnCount = 1


  g_useShortcutPrefix = itm.UseShortcutPrefix
  g_useShadertoyID    = itm.UseShadertoyID
  g_useCategoryPathes = itm.UseCategoryPathes


  local entry       = params.ListOfFuses.head -- LIST_OF_FUSES.head
  local num_wip = 0

  while entry do
    if entry.Install then
      local newitem = itm.Files:NewItem()
      newitem.Text[0] = entry.File
      itm.Files:AddTopLevelItem(newitem)
    else
      num_wip = num_wip +1
    end
    entry=entry.next
  end

  itm.NumberOfFusesLabel.Text= (params.ListOfFuses.len - num_wip) .." Fuses to be installed".. (num_wip and " ("..num_wip.." ignored)" or "")

  return win

end



function directoryExists(path, dir)

  -- Returns true, if path exists and is a directory; false otherwise.
  -- Instead of missusing the bmd.readdir() function there probably is
  --- a better way to do this!?!

  assert(path~=nil and path~="" and dir~=nil and dir~="")

	path = string.gsub(path,"\\","/")

	local handle = bmd.readdir(path..dir)

	for k, v in pairs(handle) do
		if v.Name~=nil and v.Name==dir and v.IsDir then
			return true;
		end
	end
	return false;
end



function fetchFuses(path)

  -- Traverses the directory 'path' and adds all files with the suffix
  -- 'suffix' to the 'list'. Files and directories stating with '.' are
  -- omitted!

  assert(path)

  local list = { head = nil, tail = nil, len = 0, Root = path }

  if path==nil or path=="" then
    return list
  end

  if string.sub(path,-1) ~= "/" then
    path = path.."/"
  end

  suffix = suffix or ""

  return fetchFuses_rec(path, "", list )
end


function fetchFuses_rec(path, subpath, list)

  local tail 		= head;
	local handle	= bmd.readdir(path .. subpath .. "*")
  local suffix  = ".fuse"

  for k, v in pairs(handle) do
    if (v.Name ~= nil and string.sub(v.Name,0,1) ~= ".") then
      if (v.IsDir == false) then
        if suffix=="" or string.sub(v.Name,-string.len(suffix)) == suffix then

          list.head = {
            next = list.head, File = v.Name, Path = subpath,
            Install = string.sub( v.Name,-(4+string.len(suffix)) ) ~= "_wip"..suffix and true or false
            }

          list.len  = list.len +1

        end
      else
        list = fetchFuses_rec(path, subpath..v.Name.."/", list )
      end
    end
  end

  return list
end




function getOwnPath()

  -- Return the path this script has been executed from.

  local path = debug.getinfo(2, "S").source:sub(2)
  path=path:match("(.*[/\\])")
  return path
end



function luaWarningComment()
  return
    "\n\n\n"..
    "-- // ------------------------------------------------------------------- // --\n"..
    "-- //                                                                     // --\n"..
    "-- //        A T O M A G I C A L Y   G E N E R A T E D   F I L E          // --\n"..
    "-- //                  -   D O   N O T   E D I T   -                      // --\n"..
    "-- //       W I L L   B E   O V E R W R I T T E N   W I T H O U T         // --\n"..
    "-- //              A N Y   F U R T H E R   W A R N I N G                  // --\n"..
    "-- //                                                                     // --\n"..
    "-- // ------------------------------------------------------------------- // --\n"..
    "\n\n\n\n"
end



function readFuseCode(filepath,config)

  -- Read the Fuse and replace its configuration with 'config' if the
  -- markers were found in the source.

  local cb  = "FUSE_COFIG::BEGIN"
  local ce  = "FUSE_COFIG::END"

	local f = assert(io.open(filepath, "rb"))
  local t = f:read("*all")
  f:close()

  if config ~= nil then
    pos1 = string.find(t, cb)
    if pos1~=nil then
      pos2 = string.find(t, ce, pos1)
      if pos2~=nil then
        t= string.sub(t,1,pos1+string.len(cb))..config.."-- "..string.sub(t,pos2)
      end
    end
  end

  return  luaWarningComment() .. t
end



function readThumbnail(filepath)

  local f = io.open(filepath, "rb")
  local t = nil

  if f then
    t = f:read("*all")
    f:close()

    if t and t ~= '' then
      t=base64_encode(t)
    else
      t = nil
    end
  end

  return t
end



function formatCategory(cat)

  -- Formats 'categoryPath' to be used as the category in the "Add
  -- Tools..." menu, resp the FC_CATEGORY configuration option.

  cat = cat or ""

  cat = cat:gsub("\\","/") -- just in case

  if cat:len()>0 and cat:sub(-1) == "/" then
    cat=cat:sub(1,-2)
  end

  if cat:len()>0 and cat:sub(1,1) == "/" then
    cat=cat:sub(2)
  end

  cat = cat:gsub("/","\\\\")

  return '"'..cat..'"'

end



function bailOut()
  g_disp:ExitLoop()
  os.exit()
end



function doLocalCopy(fuses)

  assert(fuses ~= nil)
  assert(g_useShadertoyID ~= nil)
  assert(g_useCategoryPathes ~= nil)
  assert(g_useShortcutPrefix ~= nil)

  local cfg =  ''
      .. 'local FC_SHORTCUT  = ' .. (g_useShadertoyID.Checked and "false" or "true")   ..'\n'
      .. 'local FC_DEVEVELOP = false\n'
      .. 'local FC_INFOBTN   = 1\n'
      .. 'local FC_PREFIX    = "BETA"\n'
      .. 'local FC_SCPREFIX  = '..  (g_useShortcutPrefix.Checked and 'FC_PREFIX' or '"ST"') .. '\n'
      .. 'local FC_SUBMENU   = "Shadertoys (beta)"\n'


  local listItem = fuses.head
  local targetSubDirectory  = TARGET_FUSES_SUBDIRECTORY .. '_beta'

  while listItem do

    if listItem.Install then
      local cat = "local FC_CATEGORY  = "..formatCategory(g_useCategoryPathes and listItem.Path or "").."\n"
      local fuseSourceCode    = readFuseCode(fuses.Root..listItem.Path..listItem.File, cat..cfg);

      if fuseSourceCode then

        if listItem.Path ~= "" then
          bmd.createdir(fusion:MapPath("Fuses:/"..targetSubDirectory.."/"..listItem.Path))
        end

        local handle = io.open(fusion:MapPath("Fuses:/"..targetSubDirectory.."/"..listItem.Path..listItem.File),"wb")
        if handle then
          handle:write(fuseSourceCode)
          handle:close()
        end

      end
    end

    listItem=listItem.next
  end
end



function doSingleInstallers(fuses)

  assert(fuses ~= nil)
  assert(g_useShadertoyID ~= nil)
  assert(g_useCategoryPathes ~= nil)
  assert(g_useShortcutPrefix ~= nil)

  local cfg =  ''
      .. 'local FC_SHORTCUT  = ' .. (g_useShadertoyID.Checked and "false" or "true")   ..'\n'
      .. 'local FC_DEVEVELOP = false\n'
      .. 'local FC_INFOBTN   = 1\n'
      .. 'local FC_PREFIX    = "BETA"\n'
      .. 'local FC_SCPREFIX  = '..  (g_useShortcutPrefix.Checked and 'FC_PREFIX' or '"ST"') .. '\n'
      .. 'local FC_SUBMENU   = "Shadertoys (beta)"\n'

  local listItem = fuses.head
  local targetSubDirectory  = TARGET_FUSES_SUBDIRECTORY .. '_beta'

  while listItem do

    if listItem.Install then

      local path            = fuses.Root..listItem.Path
      local baseFilename    = listItem.File:match('(.+)%.fuse') or nil

      assert(baseFilename ~= nil)

      local cat = "local FC_CATEGORY  = "..formatCategory(g_useCategoryPathes and listItem.Path or "").."\n"
      local fuseSourceCode    = readFuseCode(path..listItem.File, cat..cfg);

      if fuseSourceCode then

        -- printERR("path = '"..fuses.Root..listItem.Path.."")

        local ST_ID           = fuseSourceCode:match('local%s+shadertoy_id%s*=%s*"(%w+)"') or nil
        local ST_NAME         = fuseSourceCode:match('local%s+shadertoy_name%s*=%s*"([^"]+)"') or nil
        local ST_AUTHOR       = fuseSourceCode:match('local%s+shadertoy_author%s*=%s*"([^"]+)"') or nil
        local FUSE_NAME       = fuseSourceCode:match('local%s+dctlfuse_name%s*=%s*"([^"]+)"') or nil
        local FUSE_PATH       = targetSubDirectory.."/"..listItem.Path
        local FUSE_FILENAME   = listItem.File
        local FUSE_COPYRIGHT  = fuseSourceCode:match('local%s+shadertoy_license%s*=%s*"([^"]+)"') or ''
        local FUSE_AUTHOR     = fuseSourceCode:match('local%s+dctlfuse_author%s*=%s*"([^"]+)"') or nil
        local FUSE_AUTHORURL  = fuseSourceCode:match('local%s+dctlfuse_authorurl%s*=%s*"([^"]+)"') or 'https://nmbr73.github.io/Shadertoys/'
        local FUSE_VERSION    = fuseSourceCode:match('local%s+dctlfuse_versionNo%s*=%s*(%d+)') or nil
        local FUSE_THUMB      = readThumbnail(path..baseFilename .. '_320x180.png')

        if ST_ID==nil or ST_NAME == nil or ST_AUTHOR == nil or FUSE_NAME == nil or FUSE_AUTHOR == nil or FUSE_VERSION == nil then
          printERR("Skip "..listItem.File)
        elseif FUSE_THUMB == nil then
          printERR("no such thumbnail '".. path..baseFilename .. '_320x180.png' .."'")
        else

          local out = io.open(path..baseFilename..'-Installer.lua',"wb")

          if out then

            -- printERR("writing  '"..path..baseFilename..'-Installer.lua'.."'")

            out:write(luaWarningComment())

            out:write( ""
              .. "local ST_ID               = '"..ST_ID.."'\n"
              .. "local ST_NAME             = '"..ST_NAME.."'\n"
              .. "local ST_AUTHOR           = '"..ST_AUTHOR.."'\n"
              .. "local FUSE_NAME           = '"..FUSE_NAME.."'\n"
              .. "local FUSE_PATH           = '"..FUSE_PATH.."'\n"
              .. "local FUSE_FILENAME       = '"..FUSE_FILENAME.."'\n"
              .. "local FUSE_COPYRIGHT      = '"..FUSE_COPYRIGHT.."'\n"
              .. "local FUSE_AUTHOR         = '"..FUSE_AUTHOR.."'\n"
              .. "local FUSE_AUTHORURL      = '"..FUSE_AUTHORURL.."'\n"
              .. "local FUSE_VERSION        = 'v"..FUSE_VERSION.."'\n"
              .. "local FUSE_THUMB          = '"..FUSE_THUMB.."'\n"
            )

            if (FUSE_AUTHOR == 'JiPi') then
                out:write("local FUSE_AUTHORIMG= 'iVBORw0KGgoAAAANSUhEUgAAAC8AAAAYCAYAAABqWKS5AAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSIVh3ZQKZKhOlkQFXHUKhShQqgVWnUwufQLmjQkKS6OgmvBwY/FqoOLs64OroIg+AHi5uak6CIl/q8ptIjx4Lgf7+497t4BQr3MNKtrHNB020wl4mImuyoGXiFgECFEMCwzy5iTpCQ8x9c9fHy9i/Es73N/jj41ZzHAJxLPMsO0iTeIpzdtg/M+cZgVZZX4nHjMpAsSP3JdcfmNc6HJAs8Mm+nUPHGYWCx0sNLBrGhqxFPEUVXTKV/IuKxy3uKslausdU/+wmBOX1nmOs0IEljEEiSIUFBFCWXYiNGqk2IhRftxD/9Q0y+RSyFXCYwcC6hAg9z0g//B726t/OSEmxSMA90vjvMxAgR2gUbNcb6PHadxAvifgSu97a/UgZlP0mttLXoE9G8DF9dtTdkDLneAgSdDNuWm5Kcp5PPA+xl9UxYI3QK9a25vrX2cPgBp6ip5AxwcAqMFyl73eHdPZ2//nmn19wNwmHKmkuMbdwAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAd0SU1FB+UCGRMiNEXqxFgAAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAAFwUlEQVRYw82Xa2xUxxXHf3Mfu+t9+P3GuLipY8cYDAbbYMKjCQkmUeo6BEJLUBKpikppm4eKVKGoalS1aVKlUqRCv1SVFaUKRUnVJm0DUSNRRELjyphYhvCwsfHbXnu97713996dfihIBtlNUsXKni9z59zRX79zdObMDADrGlrUfc17v86n2HPNzx5+runpo2SIKQBe1eMutcvfvG9te+tiCxsbtzmmnHLvFcaPZAq8uPnxSOuTzU5f2ZExs/+BU6eO+zdu3+HxlJVnxyORlaquBfKzqup1w7HxzeMvHMg4eIBdj/10n6O6aL+7doW1zle6rT4v16MKuBpL8EEkzOTF7uffOfyDn2cKvDp/4lueM+7dcu+Rx6tqa9ubVjgq3G5KdUHdHYWssKJ8OJnckp2X+/ZY37mpjKn5m+asrGsv84f1u1fmk/Yb9Bw9FfpzZ2f/5IluapcX84CqaJ6vtezPlMxrt8xcy0W2f5SJ6VFcIUGs77w7FhjyzjgKSDfkEUuF8bpzGzMSXvj9wdCyVgZGpqioKKXmxw/q5dOx0uk8ONs7yqXxBqY+uS4yEj58+Xxf19TjMjCTI+ruVPB5VaIxGBiRXOtXmZ6ykWa/LyPhNZlFdJz0uQmferEHHCrItMSIQzJhk4hfoqSwsnF/x19fnTXeeOHv7/4hkBHd5r7NhzaWub/3NzdVOSIp0AQ4hEC1QbUF0rQo8DhYdVel2HNQb/FfKPy2N4fXhkYuJL7UbrN29Wb31tW7jnm8Vnn7d3vYsWeEXBW8CnhVgVeVVOTqtLU7ubttlMsfT6NN11fooqRmvpiUMlfeas/P+zczz7/9hu+SXNiCUsouKeWjt+nfoqH9NwKVYNjybFxfyMDZi5SUa9QVe3CShwroKgjFxu3XGBoqZ7A/i2H79d9M8v7ZJUpqDtAEHJNSWkKItxat+e7eU3GX2tk82vv0RzliZ6HpkXiyBE4d0mlBIgbxuEJiUMW2DAKxAdbXbm47H+3JvsSF0Gc6yoUo/JQlJ4GdQDVwAqi64X8KeGshDQWgYfUG9Y7clt0+Jb8wNmeRCCjMTQlCswIjAmlDolhAKs3k3DBOd4h7lq2v3l118L17Nz1c8FngFyqbBQKUQogrwD/mub+ymIYCsKHomV+Up/b8UrO84IoiLYmwIWVAPAqhIIQCEAonsW2baflJ15nhiXh1TkvzpoJvvfhF1YqUUpFSrgTun+e+vuiG/eaWZ7eWaNsOjQXmuKj8qjOtzkqpSBQN0mlIpSBtCyQSVEHK4ZcRpeeHV6zTx08PpJmdq9j0BbHvAGygb162JfDrRft8hXP7U6GALiLKdWzFrvNmFwmHraAK0BSJZUMiITBFgpQzjGlOCqElV7jUyi3BpMJodPTM/wCy/89AwsA54GUhxMlF4WdDht8lJlIpbUriME6HXHPN+aoTXXNipcFMpjF0A9OaISmDCBNk2hnff8j9SsDfu+9nHTvrvT7ZKYR4YgH92OcAPimEaPtcJ+wbXbue2br+wO9stKKkHOyeUd97KJnVVJPtKkcRCkkrQcycJWHOkCKOERlFsRPm/Tub1wA3X17pG6P3Nv2JJb0e1NSv0cg1jfr6jgPDw309djr1L9sdrgnKGKqqY2sWKSWG06eiySxUbxFutfFHx/74l8G9j7YjpUQIsUFKuQq4Z562BXy4pPBr1h3+rctb9Z2YqZNXsnV3IhHETMQoKKjiWv8/sSyT4pK7KCiopLa6DNtOsqzYXOVyXugA6pPJZKvT6dSA3tu0XxRCjC3p9SBhGCVxwyQSHqes+KtEgpMkjTl0zYERG4voyuwRI3ru++FQb7eqwsDgNU5/NHKio6MtdvVq/4O6rr8MXAHiNzZaF/CYEOInS/6GbWp9OMeVVfwNRXiLCiu2vxKcHYqascsv+fIbHpqZ6Hrp3x8c/RNA67Z9pR7f2oPR8OUztm0rXWd+/+6XfSX+D8lMtKH55bvKAAAAAElFTkSuQmCC'\n")
                out:write("local FUSE_AUTHORIMGSIZE = {47,24}\n")
            elseif (FUSE_AUTHOR == 'nmbr73') then
                out:write("local FUSE_AUTHORIMG= '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'\n")
                out:write("local FUSE_AUTHORIMGSIZE = {83,16}\n")
            else
              out:write("local FUSE_AUTHORIMG      = ''\n")
              out:write("local FUSE_AUTHORIMGSIZE  = {0,0}\n")
            end

            -- Installer-code.lua:
            out:write(base64_decode('Cgpsb2NhbCBnX2dlb21ldHJ5ICAgICAgICA9IHsxMDAsIDEwMCwgMTAyNCwgMjcwfQpsb2NhbCBnX3VpICAgICAgICAgICAgICA9IGZ1LlVJTWFuYWdlcgpsb2NhbCBnX3VpZGlzcGF0Y2hlciAgICA9IGJtZC5VSURpc3BhdGNoZXIoZ191aSkKCmxvY2FsIGdfaW5zdGFsbFdpbmRvdyA9IG5pbDsKbG9jYWwgZ19lbmRTY3JlZW4gICAgID0gbmlsOwpsb2NhbCBnX2ZpbGVFeGlzdHMgICAgPSBmYWxzZTsKCgpsb2NhbCBiPSdBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWmFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6MDEyMzQ1Njc4OSsvJwpmdW5jdGlvbiBkZWMoZGF0YSkKICAgIGRhdGEgPSBzdHJpbmcuZ3N1YihkYXRhLCAnW14nLi5iLi4nPV0nLCAnJykKICAgIHJldHVybiAoZGF0YTpnc3ViKCcuJywgZnVuY3Rpb24oeCkKICAgICAgICBpZiAoeCA9PSAnPScpIHRoZW4gcmV0dXJuICcnIGVuZAogICAgICAgIGxvY2FsIHIsZj0nJywoYjpmaW5kKHgpLTEpCiAgICAgICAgZm9yIGk9NiwxLC0xIGRvIHI9ci4uKGYlMl5pLWYlMl4oaS0xKT4wIGFuZCAnMScgb3IgJzAnKSBlbmQKICAgICAgICByZXR1cm4gcjsKICAgIGVuZCk6Z3N1YignJWQlZCVkPyVkPyVkPyVkPyVkPyVkPycsIGZ1bmN0aW9uKHgpCiAgICAgICAgaWYgKCN4IH49IDgpIHRoZW4gcmV0dXJuICcnIGVuZAogICAgICAgIGxvY2FsIGM9MAogICAgICAgIGZvciBpPTEsOCBkbyBjPWMrKHg6c3ViKGksaSk9PScxJyBhbmQgMl4oOC1pKSBvciAwKSBlbmQKICAgICAgICByZXR1cm4gc3RyaW5nLmNoYXIoYykKICAgIGVuZCkpCmVuZAoKCgoKZnVuY3Rpb24gY3JlYXRlSW5zdGFsbFdpbmRvdygpCgogIGxvY2FsIHRleHQ9JycKICBpZiBGVVNFX0FVVEhPUklNR349JycgdGhlbgogICAgdGV4dCA9JzxpbWcgc3JjPSJkYXRhOmltYWdlL3BuZztiYXNlNjQsJy4uRlVTRV9BVVRIT1JJTUcuLiciIC8+JwogIGVuZAoKCiAgZ19pbnN0YWxsV2luZG93ID0gZ191aWRpc3BhdGNoZXI6QWRkV2luZG93KHsKICAgIElEID0gJ0luc3RhbGxXaW5kb3cnLAogICAgV2luZG93VGl0bGUgPSBGVVNFX05BTUUuLicgSW5zdGFsbGVyJywKICAgIEdlb21ldHJ5ICAgID0gZ19nZW9tZXRyeSwKICAgIFNwYWNpbmcgICAgID0gMTAsCgogICAgZ191aTpWR3JvdXAgewoKICAgICAgSUQgPSAncm9vdCcsCgogICAgICBnX3VpOkhHcm91cCB7CiAgICAgICAgZ191aTpMYWJlbHsKICAgICAgICAgIElEID0gIiIsIFdvcmRXcmFwID0gZmFsc2UsIFdlaWdodCA9IDAsCiAgICAgICAgICBNaW5pbXVtU2l6ZSA9IHszMjAsIDE4MH0sIFJlYWRPbmx5ID0gdHJ1ZSwgRmxhdCA9IHRydWUsCiAgICAgICAgICBBbGlnbm1lbnQgPSB7IEFsaWduSENlbnRlciA9IGZhbHNlLCBBbGlnblRvcCA9IHRydWUsIH0sCiAgICAgICAgICBUZXh0ID0gJzxpbWcgc3JjPSJkYXRhOmltYWdlL3BuZztiYXNlNjQsJy4uIEZVU0VfVEhVTUIgLi4gJyIgLz4nLAogICAgICAgIH0sCgogICAgICAgIGdfdWk6SEdhcCgyMCksCiAgICAgICAgLS0gdWk6SEdhcCgxLjAsMC4xKSwKCiAgICAgICAgZ191aTpMYWJlbHsKICAgICAgICAgIFdlaWdodCA9IDIuMCwKICAgICAgICAgIElEID0gJ1RleHRMYWJlbCcsCiAgICAgICAgICBUZXh0ID0gJycKICAgICAgICAgICAgLi4nPGgyIHN0eWxlPSJjb2xvcjojZWZiZDc4OyAiPldlbGNvbWUgdG8gdGhlICcuLkZVU0VfTkFNRS4uJyBTZXR1cDwvaDI+JwogICAgICAgICAgICAuLic8cCBzdHlsZT0iZm9udC1zaXplOmxhcmdlOyBjb2xvcjojZmZmZmZmOyAiPicKICAgICAgICAgICAgLi4nPGEgaHJlZj0iaHR0cHM6Ly93d3cuc2hhZGVydG95LmNvbS92aWV3LycuLlNUX0lELi4nIiBzdHlsZT0iY29sb3I6cmdiKDEzOSwxNTUsMjE2KTsgdGV4dC1kZWNvcmF0aW9uOm5vbmU7ICI+Jy4uU1RfTkFNRS4uJzwvYT4gY3JlYXRlZCBieSAnCiAgICAgICAgICAgIC4uJzxhIGhyZWY9Imh0dHBzOi8vd3d3LnNoYWRlcnRveS5jb20vdXNlci8nLi5TVF9BVVRIT1IuLiciIHN0eWxlPSJjb2xvcjpyZ2IoMTM5LDE1NSwyMTYpOyB0ZXh0LWRlY29yYXRpb246bm9uZTsgIj4nLi5TVF9BVVRIT1IuLic8L2E+ICcKICAgICAgICAgICAgLi4nYW5kIHBvcnRlZCBieSA8YSBocmVmPSInLi5GVVNFX0FVVEhPUlVSTC4uJyIgc3R5bGU9ImNvbG9yOnJnYigxMzksMTU1LDIxNik7IHRleHQtZGVjb3JhdGlvbjpub25lOyAiPicuLkZVU0VfQVVUSE9SLi4nPC9hPjxiciAvPicKICAgICAgICAgICAgLi4nPHNwYW4gc3R5bGU9ImNvbG9yOmdyYXk7IGZvbnQtc2l6ZTpzbWFsbDsgIj4nLi5GVVNFX0NPUFlSSUdIVC4uJyZuYnNwOzwvc3Bhbj4nCiAgICAgICAgICAgIC4uJzwvcD4nCiAgICAgICAgICAgIC4uJzxwPicKICAgICAgICAgICAgLi4nICBUaGlzIHNjcmlwdCB3aWxsIGluc3RhbGwgXCcnLi5GVVNFX0ZJTEVOQU1FLi4nXCcgJy4uRlVTRV9WRVJTSU9OLi4nIG9uIHlvdXIgY29tcHV0ZXIuPGJyIC8+JwogICAgICAgICAgICAuLicgIFRISVMgSVMgQVQgWU9VUiBPV04gUklTSyBBTkQgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCE8YnIgLz4nCiAgICAgICAgICAgIC4uJyAgQ2xpY2sgXCdJbnN0YWxsXCcgdG8gY29udGludWUgb3IgXCdDYW5jZWxcJyB0byBleGl0IHRoZSBzZXR1cC4nCiAgICAgICAgICAgIC4uJzwvcD4nCiAgICAgICAgICAgIC4uJzxwIHN0eWxlPSJjb2xvcjojZmZmZmZmOyAiPicKICAgICAgICAgICAgLi4nICBWaXNpdCB1cyBvbiA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbm1icjczL1NoYWRlcnRveXMiIHN0eWxlPSJjb2xvcjogcmdiKDEzOSwxNTUsMjE2KTsgdGV4dC1kZWNvcmF0aW9uOm5vbmU7ICI+R2l0SHViPC9hPiBmb3IgbW9yZSBjdXRlIGxpdHRsZSBTaGFkZXJGdXNlcyEnCiAgICAgICAgICAgIC4uJzwvcD4nCiAgICAgICAgICAgIC4uKGdfZmlsZUV4aXN0cyBhbmQgJzxwIGFsaWduPSJjZW50ZXIiPjxzcGFuIHN0eWxlPSJjb2xvcjojZmZmZmZmOyBiYWNrZ3JvdW5kLWNvbG9yOiNmZjAwMDA7ICI+Jm5ic3A7QVRURU5USU9OISAnLi5GVVNFX0ZJTEVOQU1FLi4nIGRvZXMgYWxyZWFkeSBleGlzdCBhbmQgd2lsbCBiZSBvdmVyd3JpdHRlbiEmbmJzcDs8L3NwYW4+PC9wPicgb3IgJycpLAogICAgICAgICAgQWxpZ25tZW50ID0geyBBbGlnbkhDZW50ZXIgPSBmYWxzZSwgQWxpZ25WQ2VudGVyID0gZmFsc2UsIH0sCiAgICAgICAgICBXb3JkV3JhcCA9IHRydWUsCiAgICAgICAgICBPcGVuRXh0ZXJuYWxMaW5rcyA9IHRydWUsCiAgICAgICAgfSwKICAgICAgfSwKCiAgICAgIGdfdWk6TGFiZWx7CiAgICAgICAgV2VpZ2h0ID0gMCwKICAgICAgICBJRCA9ICdocicsCiAgICAgICAgVGV4dD0nPGhyIC8+JywKICAgICAgfSwKCiAgICAgIGdfdWk6SEdyb3VwewoKICAgICAgICBnX3VpOkhHYXAoNSksCiAgICAgICAgZ191aTpMYWJlbHsKICAgICAgICAgIElEID0gIiIsIFdvcmRXcmFwID0gZmFsc2UsIFdlaWdodCA9IDAsCiAgICAgICAgICBNaW5pbXVtU2l6ZSA9IEZVU0VfQVVUSE9SSU1HU0laRSwKICAgICAgICAgIFJlYWRPbmx5ID0gdHJ1ZSwgRmxhdCA9IHRydWUsCiAgICAgICAgICBBbGlnbm1lbnQgPSB7IEFsaWduSENlbnRlciA9IGZhbHNlLCBBbGlnblRvcCA9IHRydWUsIH0sCiAgICAgICAgICBUZXh0ID0gdGV4dCwKICAgICAgICB9LAoKCiAgICAgICAgV2VpZ2h0ID0gMCwKICAgICAgICBnX3VpOkhHYXAoMCwgMi4wKSwKICAgICAgICBnX3VpOkJ1dHRvbnsgIElEID0gIkluc3RhbGwiLCBUZXh0ID0gIkluc3RhbGwiLCAgICB9LAogICAgICAgIGdfdWk6QnV0dG9ueyAgSUQgPSAiQ2FuY2VsIiwgIFRleHQgPSAiQ2FuY2VsIiwgIH0sCiAgICAgIH0sCiAgICB9LAogIH0pCgogIGZ1bmN0aW9uIGdfaW5zdGFsbFdpbmRvdy5Pbi5JbnN0YWxsV2luZG93LkNsb3NlKGV2KQogICAgICBnX3VpZGlzcGF0Y2hlcjpFeGl0TG9vcCgpCiAgZW5kCgogIGZ1bmN0aW9uIGdfaW5zdGFsbFdpbmRvdy5Pbi5JbnN0YWxsLkNsaWNrZWQoZXYpCiAgICBnX2luc3RhbGxXaW5kb3c6SGlkZSgpCiAgICBpbnN0YWxsKCkKICBlbmQKCiAgZnVuY3Rpb24gZ19pbnN0YWxsV2luZG93Lk9uLkNhbmNlbC5DbGlja2VkKGV2KQogICAgZ191aWRpc3BhdGNoZXI6RXhpdExvb3AoKQogIGVuZAplbmQKCgpmdW5jdGlvbiBjcmVhdGVFbmRTY3JlZW4oKQoKICBsb2NhbCB0ZXh0PScnCiAgaWYgZ19maWxlRXhpc3RzIHRoZW4KICAgIHRleHQ9JzxwPkFzIHlvdSBhbHJlYWR5IGhhZCB0aGlzIEZ1c2UgaW5zdGFsbGVkLCB5b3UgbWF5IG5vdCBuZWVkIHRvIHJlc3RhcnQgdGhlIGFwcGxpY2F0aW9uLiBCdXQgY2hhbmNlcyBhcmUsIHRoYXQgeW91IGhhdmUganVzdCBvdmVyd3JpdHRlbiB0aGUgc2FtZSB2ZXJzaW9uIGFuZCB3aWxsIG5vdCBmaW5kIGFueXRoaW5nIG5ldy4gJwogIGVsc2UKICAgIHRleHQ9JzxwPkluIG9yZGVyIHRvIHVzZSB0aGUgbmV3bHkgaW5zdGFsbGVkIFBsdWctaW4geW91IHdpbGwgbmVlZCB0byByZXN0YXJ0IERhVmluY2kgUmVzb2x2ZSAvIEZ1c2lvbi4gJwogIGVuZAoKICB0ZXh0ID0gdGV4dCAuLiAnSG93ZXZlciwgZ28gaW50byBGdXNpb24sIHNtYXNoIHRoZSBcJ1NoaWZ0K1NwYWNlXCcgc2hvcnRjdXQgYW5kIHNlYXJjaCBmb3IgIicuLkZVU0VfTkFNRS4uJyIgdG8gYWRkIHRoaXMgdHlwZSBvZiBub2RlIC0gYW5kIHRoZW4gLi4uPC9wPjxwIHN0eWxlPSJjb2xvcjojZmZmZmZmOyAiPkhhdmUgRnVuIScKCiAgaWYgRlVTRV9BVVRIT1JJTUd+PScnIHRoZW4KICAgIHRleHQ9dGV4dC4uJzxiciAvPjxpbWcgc3JjPSJkYXRhOmltYWdlL3BuZztiYXNlNjQsJy4uRlVTRV9BVVRIT1JJTUcuLiciIC8+PC9wPicKICBlbHNlCiAgICB0ZXh0PXRleHQuLic8L3A+JwogIGVuZAoKCiAgZ19lbmRTY3JlZW4gPSBnX3VpZGlzcGF0Y2hlcjpBZGRXaW5kb3coewogICAgSUQgPSAnRW5kU2NyZWVuJywKICAgIFdpbmRvd1RpdGxlID0gRlVTRV9OQU1FLi4nIEluc3RhbGxlZCcsCiAgICBHZW9tZXRyeSA9IHszMDAsIDEwMCwgNjQwLCAyNzB9LAoKICAgIGdfdWk6Vkdyb3VwewogICAgICBJRCA9ICdyb290JywKCiAgICAgIGdfdWk6TGFiZWx7CiAgICAgICAgICBXZWlnaHQgPSAxLjAsIElEID0gJ0ZpbmFsVGV4dExhYmVsJywKICAgICAgICAgIFRleHQgPSc8aDI+SW5zdGFsbGF0aW9uIG9mIDxzcGFuIHN0eWxlPSJjb2xvcjojZmZmZmZmOyAiPicuLkZVU0VfTkFNRS4uJzwvc3Bhbj4gKGhvcGVmdWxseSkgY29tcGxldGVkPC9oMj48cD4nLi50ZXh0Li4nPC9wPicsCiAgICAgICAgICBBbGlnbm1lbnQgPSB7IEFsaWduSENlbnRlciA9IHRydWUsIEFsaWduVlRvcCA9IHRydWUsIH0sCiAgICAgICAgICBXb3JkV3JhcCA9IHRydWUsCiAgICAgIH0sCgogICAgICBnX3VpOkhHcm91cHsKICAgICAgICBXZWlnaHQgPSAwLAogICAgICAgIGdfdWk6SEdhcCgwLCAyLjApLAogICAgICAgIGdfdWk6QnV0dG9ueyBXZWlnaHQgPSAwLjEsIElEID0gIk9rYXkiLCBUZXh0ID0gIk9rYXkiLCB9LAogICAgICAgIGdfdWk6SEdhcCgwLCAyLjApLAogICAgICB9LAogICAgfSwKICB9KQoKICBmdW5jdGlvbiBnX2VuZFNjcmVlbi5Pbi5FbmRTY3JlZW4uQ2xvc2UoZXYpCiAgICAgIGdfdWlkaXNwYXRjaGVyOkV4aXRMb29wKCkKICBlbmQKCiAgZnVuY3Rpb24gZ19lbmRTY3JlZW4uT24uT2theS5DbGlja2VkKGV2KQogICAgICBnX3VpZGlzcGF0Y2hlcjpFeGl0TG9vcCgpCiAgZW5kCgplbmQKCgpmdW5jdGlvbiBmaWxlRXhpc3RzKHBhdGgsIGZpbGUpCgogIGFzc2VydChwYXRofj1uaWwgYW5kIHBhdGh+PScnKQogIGFzc2VydChmaWxlfj1uaWwgYW5kIGZpbGV+PScnKQoKCWxvY2FsIGggPSBibWQucmVhZGRpcihwYXRoLi5maWxlKQoKCWZvciBrLCB2IGluIHBhaXJzKGgpIGRvCiAgICBpZiB2Lk5hbWV+PW5pbCBhbmQgdi5OYW1lPT1maWxlIHRoZW4KICAgICAgcmV0dXJuIHRydWU7CiAgICBlbmQKCWVuZAoKCXJldHVybiBmYWxzZTsKZW5kCgoKCmZ1bmN0aW9uIGluc3RhbGwoKQoKICBibWQuY3JlYXRlZGlyKGZ1c2lvbjpNYXBQYXRoKCdGdXNlczovJy4uRlVTRV9QQVRIKSk7CgogIGxvY2FsIGYgPSBpby5vcGVuKGZ1c2lvbjpNYXBQYXRoKCdGdXNlczovJy4uRlVTRV9QQVRILi5GVVNFX0ZJTEVOQU1FKSwid2IiKQogIHdyaXRlRnVzZUNvZGUoZik7CiAgZjpjbG9zZSgpCiAgZ19lbmRTY3JlZW46U2hvdygpCmVuZAoKCgpmdW5jdGlvbiBnb0Zvckl0KCkKCiAgZ19maWxlRXhpc3RzICAgID0gIGZpbGVFeGlzdHMoZnVzaW9uOk1hcFBhdGgoJ0Z1c2VzOi8nLi5GVVNFX1BBVEgpLCBGVVNFX0ZJTEVOQU1FKQoKICBjcmVhdGVJbnN0YWxsV2luZG93KCkKICBjcmVhdGVFbmRTY3JlZW4oKQoKICBnX2luc3RhbGxXaW5kb3c6U2hvdygpCiAgZ191aWRpc3BhdGNoZXI6UnVuTG9vcCgpCiAgZ19lbmRTY3JlZW46SGlkZSgpCmVuZAo='))

            -- fuseSourceCode = fuseSourceCode:gsub("\r","") -- that's rought, but I guess we don't need line feeds - hope this help with Windows/Unix line endings

            out:write(
                 'function writeFuseCode(f)\n'
              .. '  f:write(dec("'..base64_encode(fuseSourceCode)..'"))\n'
              .. 'end\n'
              .. 'goForIt()\n'
                 )

            out:close()

          end

          -- bailOut()
        end

        -- if listItem.Path ~= "" then
        --   bmd.createdir(fusion:MapPath("Fuses:/"..targetSubDirectory.."/"..listItem.Path))
        -- end

        -- local handle = io.open(fusion:MapPath("Fuses:/"..targetSubDirectory.."/"..listItem.Path..listItem.File),"wb")
        -- if handle then
        --   handle:write(fuseSourceCode)
        --   handle:close()
        -- end

      end
    end

    listItem=listItem.next
  end
end



function doCreateInstaller(fuses)
  printERR("doCreateInstaller")
  bailOut()
end



function doPrepareSuggestion(fuses)
  printERR("doCreateInstaller")
  bailOut()
end



function doNothing()
  printERR("doNothing")
  bailOut()
end



function getTargetDirectory()
  return fusion:MapPath("Fuses:/")..TARGET_FUSES_SUBDIRECTORY.."/"
end



function logo()
  return g_ui:Label{
    ID = "",
    WordWrap = false,
    Weight = 0,
    MinimumSize = {274, 63},
    ReadOnly = true,
    Flat = true,
    Alignment = { AlignHCenter = false, AlignTop = true, },
    Text = '<img src="data:image/png;base64,'
    ..'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'
    ..'">',
  }

end



-- ----------------------------------------------------------------------



local listOfFuses         = fetchFuses(getOwnPath())
local targetIsGitRepo     = directoryExists(getTargetDirectory(),".git")
local installModeOptions  = initInstallModeOptions( { TargetIsGitRepo = targetIsGitRepo, } )
local installMainWindow   = initMainWindow( { InstallModeOptions = installModeOptions, ListOfFuses=listOfFuses, })
local installSelectWindow = initInstallSelectWindow( { InstallModeOptions = installModeOptions, NextWindow = installMainWindow })

installSelectWindow:Show()
g_disp:RunLoop()
