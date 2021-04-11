require("string")

local user_config = require("Shadertoys/~user_config")
local fuses       = require("Shadertoys/fuses")


fuses.fetch(user_config.pathToRepository..'Shaders/',true)


local handle = io.open(user_config.pathToRepository..'Shaders/OVERVIEW.md',"wb")

if not(handle) then
  print("We have a Problem")
  os.exit(10)
end

--  handle:write(fuseSourceCode)

handle:write([[

<!--                                                             -->
<!--           THIS IS AN AUTOMATICALLY GENERATED FILE           -->
<!--                                                             -->
<!--                  D O   N O T   E D I T ! ! !                -->
<!--                                                             -->
<!--  ALL CHANGES WILL BE OVERWRITTEN WITHOUT ANY FURTHER NOTICE -->
<!--                                                             -->

]])

handle:write('# Shaders\n\n')



local currentCategory=''

for i, fuse in ipairs(fuses.list) do

  if fuse.file_category ~= currentCategory then
    currentCategory=fuse.file_category

    handle:write(
      "\n\n## "..fuse.file_category.." Shaders\n\n"..
      "Preview  | Information\n"..
      "---------|------------\n"
    )

  end

  handle:write(
      '[!['..fuse.file_category..'/'..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'_320x180.png)]('..fuse.file_category..'/'..fuse.file_filename..'.md)'
    ..'|'
    ..'<nobr>Fuse: ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md)</nobr><br />'
    ..'<nobr>Category: ['..fuse.file_category..']('..fuse.file_category..'/OVERVIEW.md)</nobr><br />'
    )


  if not(fuse.error) then
    handle:write(
        '<nobr>Shadertoy: ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')</nobr><br />'
      ..'<nobr>Author: ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')</nobr><br />'
      ..'<nobr>Ported by: ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)</nobr><br />'
      )
  else
    handle:write('<span style="color:red; ">'..fuse.error..'</span>')
  end

  handle:write('\n')

end

handle:close()
