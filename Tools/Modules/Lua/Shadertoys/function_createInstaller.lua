require("string")

-- fuse.name
-- fuse.author
-- fuse.author_url
-- shadertoy.id
-- shadertoy.name
-- shadertoy.author
-- shadertoy.license (default '(c) AUTHOR (CC BY-NC-SA 3.0)')

-- minilogo.image (default: '') ... '<img src="data:image/png;base64,..." />'
-- minilogo.width (default: 0)
-- minilogo.height (default: 0)
-- minilogo.image (default: '')
-- thumbnail.data (always exists, and always has a size of 320x180px)


-- (x) thumbnail.image ("<img src="data:image/png;base64,..." />"; always exists, and always has a size of 320x180px)
-- (x) minilogo.data (default: '')
-- (x) minilogo.exists (defaut: false)


function createInstaller()

    local user_config = require("Shadertoys/~user_config")
    local fuses       = require("Shadertoys/fuses")

    fuses.fetch(user_config.pathToRepository..'Shaders/',false)

    for i, fuse in ipairs(fuses.list) do

        fuse:read()

        -- fuse.fuse_sourceCode=snippet.replace(fuse.fuse_sourceCode)


    end


end
