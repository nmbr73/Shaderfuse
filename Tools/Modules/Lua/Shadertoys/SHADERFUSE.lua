

-- Shadertoy.Name = "Rainbow Slices", -- optional, but should be given; the original name (defaults to Fuse.Name)
-- Shadertoy.Author = "fizzer",       -- mandatory
-- Shadertoy.ID = "XdsGD4",           -- mandatory
-- Shadertoy.License = "",            -- optional (defaults to CC BY-NC-SA)
-- Fuse.Name = "RainbowSlices",       -- optional (defaults to Fuse.FileName)
-- Fuse.Author = "nmbr73",            -- mandatory
-- Fuse.AuthorURL                     -- optional (nil for default, '' to supress)
-- Fuse.AuthorLogo                    -- optional (nil for default, '' to supress)
-- Fuse.Description                   -- optional
-- Fuse.FileName                      -- auto
-- Fuse.Category                      -- auto
-- Fuse.isCompatible                  -- auto
-- Fuse.Version = "v1.0.0"            -- optional; but if given then it must be in that exact format

-- Shadertoy.Description = ""         -- optional (description from Shadertoy.com) ... NOT USED YET
-- Shadertoy.Tags = []                -- optional ... NOT USED YET

-- Compatibility.macOS_Metal = nil|true|false|'...'     -- optional (if not given, then it's incompatible!)
-- Compatibility.macOS_OpenCL = nil|true|false|'...'    -- optional (if not given, then it's incompatible!)
-- Compatibility.Windows_CUDA = nil|true|false|'...'    -- optional (if not given, then it's incompatible!)
-- Compatibility.Windows_OpenCL = nil|true|false|'...'  -- optional (if not given, then it's incompatible!)

-- true  == checked and it works
-- nil   == not tested yet
-- false == does not work (no more details)
-- '...' == does not work with '...' decribing the problem



function SHADERFUSE_INIT(filepath)

    if SHADERFUSE ~= nil then
        print("Exists !?!?")
    end


    filepath = filepath ~= nil and filepath or debug.getinfo(2, "S").source:sub(2)
    assert(filepath,"filepath could not be determined")

    local path, category, fusefilename = filepath:match("(.*/)([^/]+)/(.+)%.fuse")
    assert(path ~= nil and category ~= nil and fusefilename ~= nil, "filepath missmatch")

    dofile(path .. category .. '/' .. fusefilename .. '.info')

    -- mandatory fields
    assert(info ~= nil, "no info")
    assert(info.Shadertoy ~= nil, "no info.Shadertoy")
    assert(info.Shadertoy.ID ~= nil, "no info.Shadertoy.ID")
    assert(info.Shadertoy.Author ~= nil, "no info.Shadertoy.Author")
    assert(info.Fuse ~= nil, "no info.Fuse")
    assert(info.Fuse.Author ~= nil, "no info.Fuse.AUthor")

    -- auto fields
    assert(info.Fuse.Category == nil, "Fuse.Category must not be set explicitely")
    assert(info.Fuse.FileName == nil, "Fuse.FileName must not be set explicitely")
    assert(info.Fuse.FuRegister == nil, "Fuse.FuRegister must not be set explicitely")
    assert(info.Fuse.isCompatible == nil, "Fuse.isCompatible must not be set explicitely")

    info.Fuse.Category = category
    info.Fuse.FileName = fusefilename

    -- defaults
    if info.Fuse.Name == nil then info.Fuse.Name = fusefilename end -- Fuse.Name defaults to filename
    if info.Shadertoy.Name == nil then info.Shadertoy.Name = info.Fuse.Name end -- Shadertoy.Name defaults to Fuse.Name
    if info.Shadertoy.License == nil then info.Shadertoy.License = "Copyright "..info.Shadertoy.Author.." (CC BY-NC-SA 3.0)" end -- Shadertoy.com licenses defaults to CC BY-NC-SA 3.0 if not explicitely stated otherwise
    if info.Fuse.Description == nil then info.Fuse.Description = '' end
    if info.Shadertoy.Tags == nil then info.Shadertoy.Tags = {} end

    assert(info.Shadertoy.License ~= '', "Shadertoy.License must not be empty")


    info.FuRegister = {}
    info.FuRegister.Name = "ST_"..info.Fuse.Name
    info.FuRegister.Attributes = {
        -- REG_Fuse_TilePic = nil, TODO!
        REGS_Category = "Shadertoys (dev)\\"..info.Fuse.Category,
        REGS_OpIconString = "ST-"..info.Shadertoy.ID,
        REGS_Company = info.Fuse.Author,
        REGS_URL = (info.Fuse.AuthorURL == nil or info.Fuse.AuthorURL == '') and "https://nmbr73.github.io/Shadertoys/" or info.Fuse.AuthorURL,
        REGS_OpDescription =
            "Shadertoy '".. info.Shadertoy.Name .."' (ID: ".. info.Shadertoy.ID ..") created by "
            .. info.Shadertoy.Author .." and ported by ".. info.Fuse.Author .. ". ".. info.Shadertoy.License .. "."
            .. (info.Fuse.Description ~= '' and " "..info.Fuse.Description.." " or " ")
            .. "This port is by no means meant to take advantage of anyone or to do anyone wrong: "
            .. "Contact us on Discord (https://discord.gg/75FUn4N4pv) and/or GitHub (https://github.com/nmbr73/Shadertoys) "
            .. "if you see your rights abused or your intellectual property violated by this work.",
        REG_Fuse_NoEdit = false,
        REG_Fuse_NoReload = false,
    }



    -- Compatibility

    if info.Compatibility == nil then info.Compatibility = {} end

    assert(info.Compatibility_issues == nil, "Compatibility_issues must not be set")

    info.Compatibility_issues = {}
    info.Fuse.isCompatible = true

    for k , _ in pairs(info.Compatibility) do
        assert( k == 'macOS_Metal' or k == 'macOS_OpenCL' or k == 'Windows_CUDA' or k == 'Windows_OpenCL', "invalid compatibility key")
    end

    for _ , k in pairs({'macOS_Metal','macOS_OpenCL','Windows_CUDA','Windows_OpenCL'}) do

        local v = info.Compatibility[k]
        local i = ''

        if v == nil then
            i = 'not checked'
            v = false
        elseif v == true then
            i = ''
        elseif v == false then
            i = 'does not work; no more details given'
        else
            i = v
            v = false
        end

        info.Compatibility[k] = v
        info.Compatibility_issues[k] = i
        info.Fuse.isCompatible = info.Fuse.isCompatible and v
    end

    return info
end
