require("string")

function createInstaller()

    local user_config = require("Shadertoys/~user_config")
    local fuses       = require("Shadertoys/fuses")

    fuses.fetch(user_config.pathToRepository..'Shaders/',false)

    for i, fuse in ipairs(fuses.list) do

        fuse:read()

        -- fuse.fuse_sourceCode=snippet.replace(fuse.fuse_sourceCode)


    end


end
