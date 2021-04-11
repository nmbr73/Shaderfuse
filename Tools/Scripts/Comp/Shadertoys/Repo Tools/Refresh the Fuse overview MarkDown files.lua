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

    if currentCategory~='' then
      handle:write('</table>\n\n')
    end

    currentCategory=fuse.file_category

    handle:write(
      "## "..fuse.file_category.." Shaders\n\n<table>"
    )

  end

  handle:write(
      '<tr>\n'
    ..'<td>'
    ..'<img src="'..fuse.file_category..'/'..fuse.file_fusename..'_320x180.png" alt="'..fuse.file_category..'/'..fuse.file_fusename..'" width="320" height="180" />'
    ..'</td>\n<td><p>\n\n'..(not(fuse.error) and ':four_leaf_clover:' or ':boom:')..'</p>\n<p>\n\n'
    ..'<nobr>Fuse: ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md)</nobr><br />\n'
    ..'<nobr>Category: ['..fuse.file_category..']('..fuse.file_category..'/OVERVIEW.md)</nobr><br />\n'
    )


  if (not(fuse.error)) then
    handle:write(
        '<nobr>Shadertoy: ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')</nobr><br />\n'
      ..'<nobr>Author: ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')</nobr><br />\n'
      ..'<nobr>Ported by: ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)</nobr><br />\n'
      )
  else
    handle:write('</p><p style="color:red; font-weight:bold; ">'..fuse.error)
  end

  handle:write('</p>\n</td></tr>\n')

end

if currentCategory~='' then
  handle:write('</table>\n')
end


handle:close()
