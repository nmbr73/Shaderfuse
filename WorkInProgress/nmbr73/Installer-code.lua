


--   =========================================================================
--
--             A T O M A G I C A L Y   G E N E R A T E D   F I L E
--
--                       -   D O   N O T   E D I T   -
--
--            W I L L   B E   O V E R W R I T T E N   W I T H O U T
--                   A N Y   F U R T H E R   W A R N I N G
--
--   =========================================================================
--
--   Fuse:    {{> Fuse.Name <}} by {{> Fuse.Author <}}
--   Shader:  {{> Shadertoy.ID <}} (https://www.shadertoy.com/view/{{> Shadertoy.ID <}})
--   License: {{> Shadertoy.License <}}
--   Version: {{> fuse.hash <}} (beta)
--   Date:    {{> fuse.date <}}
--
--   -------------------------------------------------------------------------
--
--   This is an installer file for Blackmagic's DaVinci Resolve and/or Fusion
--   application. See https://github.com/nmbr73/Shaderfuse for context. If you
--   are very brave, or simply completely tired of life, then you can drag and
--   drop this file onto your Fusion composition's working area. Good luck!
--
--   =========================================================================


local ui            = fu.UIManager
local uidispatcher  = bmd.UIDispatcher(ui)

-- git log -n 1 --pretty="format:%h %cs" -- <FILE>
-- liefert: '97f7ee0 2022-12-19'


function dec(data)
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



function file_exists(path, file)

    assert(path~=nil and path~='')
    assert(file~=nil and file~='')

    local f = io.open(path..file,"r")
    if f ~= nil then
        io.close(f)
        return true
    end

    return false;
end



function InstallWindow()

    local fuseFileExists = file_exists(fusion:MapPath('Fuses:/Shaderfuse_beta'), '{{> Shadertoy.ID <}}_b.fuse')

    local installWindow = uidispatcher:AddWindow({
        ID = 'InstallWindow',
        WindowTitle = '{{> Fuse.Name <}} Installer',
        Geometry = {100, 100, 1024, 270},
        Spacing = 10,

        ui:VGroup {

            ID = 'root',

            ui:HGroup {
                ui:Label {
                    ID = "thumbnail", WordWrap = false, Weight = 0,
                    MinimumSize = {320, 180}, ReadOnly = true, Flat = true,
                    Alignment = { AlignHCenter = false, AlignTop = true, },
                    Text = '<img width="320" height="180" src="data:image/png;base64,{{> thumbnail.data <}}" />',
                },

                ui:HGap(20),

                ui:Label {
                    ID = 'text', WordWrap = true, Weight = 2.0,
                    OpenExternalLinks = true,
                    Alignment = { AlignHCenter = false, AlignVCenter = false, },

                    Text = [[
                        <h2 style="color:#efbd78; ">Welcome to the {{> Fuse.Name <}} Setup</h2>
                        <p style="font-size:large; color:#ffffff; ">
                            <a href="https://www.shadertoy.com/view/{{> Shadertoy.ID <}}" style="color:rgb(139,155,216); text-decoration:none; ">{{> Shadertoy.Name <}}</a> created by
                            <a href="https://www.shadertoy.com/user/{{> Shadertoy.Author <}}" style="color:rgb(139,155,216); text-decoration:none; ">{{> Shadertoy.Author <}}</a>
                            and ported by <a href="{{> Fuse.AuthorURL <}}" style="color:rgb(139,155,216); text-decoration:none; ">{{> Fuse.Author <}}</a><br />
                            <span style="color:gray; font-size:small; "{{> Shadertoy.License <}}&nbsp;</span>
                        </p>
                        <p>
                            This script will install \'Shaderfuse_beta/{{> Shadertoy.ID <}}_b.fuse\' on your computer.<br />
                            THIS IS AT YOUR OWN RISK AND WITHOUT WARRANTY OF ANY KIND!<br />
                            Click 'Cancel' to exit the setup.
                        </p>'
                        <p style="color:#ffffff; ">
                            Visit us on <a href="https://github.com/nmbr73/Shadertoys" style="color: rgb(139,155,216); text-decoration:none; ">GitHub</a> for more cute little ShaderFuses!
                        </p>'
                        ]]
                        ..(fuseFileExists and [[<p align="center"><span style="color:#ffffff; "><span sytle="background-color:#ff0000; ">&nbsp;ATTENTION!&nbsp;</span><span style="background-color:#000000; ">&nbsp;Fuse already exists and will be deleted resp. overwritten!&nbsp;</span></span></p>]] or ''),
                },
            },

            ui:Label { Weight = 0, ID = 'hr', Text='<hr />', },

            ui:HGroup{

                Weight = 0,

                ui:HGap(5),

                ui:Label {
                    ID = "logo", WordWrap = false, Weight = 0,
                    MinimumSize = { {{> minilogo.width <}}, {{> minilogo.height <}} },
                    ReadOnly = true, Flat = true,
                    Alignment = { AlignHCenter = false, AlignTop = true, },
                    Text = '{{> minilogo.image <}}',
                },

                ui:HGap(0, 2.0),

                ui:Button{  ID = "Uninstall", Text = "Uninstall", Hidden = (not fuseFileExists),  },
                ui:Button{  ID = "Install", Text = (fuseFileExists and "Overwrite" or "Install"),    },
                ui:Button{  ID = "Cancel",  Text = "Cancel",  },
            },
        },
    })

    function installWindow.On.Uninstall.Clicked(ev)
        installWindow:Hide()
        uninstall_action()
    end

    function installWindow.On.Install.Clicked(ev)
        installWindow:Hide()
        install_action(fuseFileExists)
    end

    function installWindow.On.InstallWindow.Close(ev)
        uidispatcher:ExitLoop()
    end

    function installWindow.On.Cancel.Clicked(ev)
        installWindow:Hide()
        uidispatcher:ExitLoop()
    end

    return installWindow
end



function EndScreen(text)

    local endScreen = uidispatcher:AddWindow({
        ID = 'EndScreen',
        WindowTitle = '{{> Fuse.Name <}} Installed',
        Geometry = {300, 100, 640, 270},

        ui:VGroup{
            ID = 'root',

            ui:Label{
                Weight = 1.0, ID = 'FinalTextLabel',
                Text = text .. '<p>{{> minilogo.image <}}</p>',
                Alignment = { AlignHCenter = true, AlignVTop = true, },
                WordWrap = true,
            },

            ui:HGroup{
                Weight = 0,
                ui:HGap(0, 2.0),
                ui:Button{ Weight = 0.1, ID = "Okay", Text = "Okay", },
                ui:HGap(0, 2.0),
            },
        },
    })

  function endScreen.On.EndScreen.Close(ev)
      uidispatcher:ExitLoop()
  end

  function endScreen.On.Okay.Clicked(ev)
    endScreen:Hide()
    uidispatcher:ExitLoop()
  end

  return endScreen
end



function write_fuse()

    local f = io.open(fusion:MapPath('Fuses:/Shaderfuse_beta/{{> Shadertoy.ID <}}_b.fuse'),"wb")

    if not f then return false end

    writeFuseCode(f);
    f:close()

    local t = io.open(fusion:MapPath('Fuses:/Shaderfuse_beta/{{> Shadertoy.ID <}}_b.png'),"wb")

    if not t then return false end

    t:write(dec("{{> thumbnail.data <}}"))
    t:close()

end



function install_action(overwrite)

    local text = ''

    if not overwrite then
        bmd.createdir(fusion:MapPath('Fuses:/Shaderfuse_beta'))
    end

    if write_fuse() then

        if not overwrite then
            text = [[
                <h2>Installation of <span style="color:#ffffff; ">{{> Fuse.Name <}}</span> (hopefully) completed</h2>
                <p>
                    In order to use the newly installed fuse (aka tool; kind of a plug-in) you will need to restart DaVinci Resolve / Fusion.
                </p>
                <p>
                    Then go into your Fusion composition workspace, smash the \'Shift+Space\' shortcut and search for "{{> Fuse.Name <}}"
                    to add this type of node - and then ...
                </p>
                <p style="color:#ffffff; ">Have Fun!</p>
            ]]
        else
            text = [[
                <h2>Update of <span style="color:#ffffff; ">{{> Fuse.Name <}}</span> (hopefully) done</h2>
                <p>
                    As you already had this Fuse installed, you may not need to restart the application. But chances are,
                    that you have just overwritten the same version and will not find anything new.
                </p>
                <p>
                    However, just add a "{{> Fuse.Name <}}" node to your composition to check it out - and then ...
                </p>
                <p style="color:#ffffff; ">Enjoy!</p>
            ]]
        end

    else

        text = [[
            <h2>Installation of <span style="color:#ffffff; ">{{> Fuse.Name <}}</span> failed!</h2>
            <p>
                Tried to write '{{> Shadertoy.ID <}}_b.fuse' and '{{> Shadertoy.ID <}}_b.png' files
                into the 'Shaderfuse_beta' subfolder of your 'Fuses' directory, but ...
            <h2 style="color:#ff0000; ">Something went terribly wrong!</h2>
            <p style="color:#ffffff; ">Dang!</p>
        ]]

    end

    local endScreen = endScreen(text)
    endScreen:Show()
end



function uninstall_action()

    local fusefilepath = fusion:MapPath('Fuses:/Shaderfuse_beta/{{> Shadertoy.ID <}}_b.fuse')
    local thumbfilepath = fusion:MapPath('Fuses:/Shaderfuse_beta/{{> Shadertoy.ID <}}_b.png')

    os.remove(fusefilepath)
    os.remove(thumbfilepath)

    local text = [[
        <h2><span style="color:#ffffff; ">{{> Fuse.Name <}}</span> has (hopefully) been <span style="color:#ff0000; ">uninstalled</span></h2>
        <p>
            This should have removed the '{{> Shadertoy.ID <}}_b.fuse' and '{{> Shadertoy.ID <}}_b.png' files from
            the 'Shaderfuse_beta' folder in your 'Fuses' directory.
        </p>
        <p>
            However, if you restart DaFusion, then the "{{> Fuse.Name <}}" tool should be gone with the wind ...
        </p>
        <p style="color:#ffffff; ">Cheers!</p>
    ]]

    local endScreen = endScreen(text)
    endScreen:Show()

end



function goForIt()

    local installWindow = InstallWindow()
    installWindow:Show()
    uidispatcher:RunLoop()

end
