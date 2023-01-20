require("string")

-- Fuse.Name
-- Fuse.Author
-- fuse.author_url
-- Shadertoy.ID
-- Shadertoy.Name
-- Shadertoy.Author
-- Shadertoy.License (default '(c) AUTHOR (CC BY-NC-SA 3.0)')

-- minilogo.image (default: '') ... '<img src="data:image/png;base64,..." />'
-- minilogo.width (default: 0)
-- minilogo.height (default: 0)
-- minilogo.image (default: '')
-- thumbnail.data (always exists, and always has a size of 320x180px)


-- (x) thumbnail.image ("<img src="data:image/png;base64,..." />"; always exists, and always has a size of 320x180px)
-- (x) minilogo.data (default: '')
-- (x) minilogo.exists (defaut: false)

Fuse = require("Shadertoys/Fuse")

function createInstaller(fusefilepath)


    local fuse = Fuse:new(fusefilepath,'installer',true)

    fuse:print()

end


function createInstallers(repositorypath)

    -- local fuse = Fuse:new("/Users/nmbr73/Projects/Shadertoys/Shaders/Wedding/Heartdemo.fuse")

    fuses.fetch(repositorypath..'/Shaders/',false)

    for i, fuse in ipairs(fuses.list) do

        print("Name: '".. fuse.Name .."'")
        -- fuse:read()
        -- fuse.fuse_sourceCode=snippet.replace(fuse.fuse_sourceCode)


    end


end

