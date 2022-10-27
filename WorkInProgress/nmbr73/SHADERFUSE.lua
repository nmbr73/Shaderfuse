

-- Shadertoy.Name = "Rainbow Slices", -- mandatory, the original name
-- Shadertoy.Author = "fizzer",       -- mandatory
-- Shadertoy.ID = "XdsGD4",           -- mandatory
-- Shadertoy.License = "",            -- optional (defaults to CC BY-NC-SA)
-- Fuse.Name = "RainbowSlices",       -- optional (defaults to filename)
-- Fuse.Author = "nmbr73",            -- mandatory
-- Fuse.FileName                      -- auto
-- Fuse.Category                      -- auto
-- Fuse.AuthorURL                     -- optional (nil for default, '' to supress)
-- Fuse.AuthorLogo                    -- optional (nil for default, '' to supress)


function SHADERFUSE_INIT(filepath)

    if SHADERFUSE ~= nil then
        print("Exists !?!?")
    end

    if filepath == nil then
        filepath = debug.getinfo(2, "S").source:sub(2)
    end

    local path, category, fusefilename = filepath:match("(.*/)([^/]+)/(.+)%.fuse")

    dofile(path .. category .. '/' .. fusefilename .. '.info')


    -- Shadertoy.com licenses defaults to CC BY-NC-SA 3.0 if not explicitely stated otherwise
    if info.License == nil then
        info.Shadertoy.License = "Copyright "..info.Fuse.Author.." (CC BY-NC-SA 3.0)"
    end

    -- Fuse.Name should be given (default is filename if not)
    if info.Fuse.Name == nil then
        info.Fuse.Name = fusefilename
    end

    info.Fuse.FileName = fusefilename
    info.Fuse.Category = category

    info.FuRegister = {}
    info.FuRegister.Name = "ST_"..info.Fuse.Name
    info.FuRegister.Attributes = {
        REGS_OpDescription = "Shadertoy '".. info.Shadertoy.Name .."' (ID: ".. info.Shadertoy.ID ..") created by ".. info.Shadertoy.Author .." and ported by ".. info.Fuse.Author .. ". ".. info.Shadertoy.License .. ". This port is by no means meant to take advantage of anyone or to do anyone wrong : Contact us on Discord (https://discord.gg/75FUn4N4pv) and/or GitHub (https://github.com/nmbr73/Shadertoys) if you see your rights abused or your intellectual property violated by this work.",
        REG_Fuse_NoEdit = false,
        REG_Fuse_NoReload = false,
    }


    return info
end


