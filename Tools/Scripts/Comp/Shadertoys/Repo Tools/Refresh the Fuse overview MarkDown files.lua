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

<style type="text/css">
  p.error {color:red;}
</style>

]])

handle:write('# Shaders\n\n')



local currentCategory=''

for i, fuse in ipairs(fuses.list) do

  if fuse.file_category ~= currentCategory then

    if currentCategory~='' then
      handle:write('</table>\n')
    end

    currentCategory=fuse.file_category

    handle:write(
      "\n\n## "..fuse.file_category.." Shaders\n\n<table>"
--      .."Preview  | Information\n"
--      .."---------|------------\n"
    )

  end

  handle:write(
      '<tr>\n  <td>'
    ..'[!['..fuse.file_category..'/'..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'_320x180.png)]('..fuse.file_category..'/'..fuse.file_filename..'.md)'
    ..'</td>\n  <td><p>'..(fuse.error and ':boom:' or ':four_leaf_clover:')..'</p><p>'
    ..'<nobr>Fuse: ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md)</nobr><br />'
    ..'<nobr>Category: ['..fuse.file_category..']('..fuse.file_category..'/OVERVIEW.md)</nobr><br />'
    )


  if (fuse.error) then
    handle:write(
        '<nobr>Shadertoy: ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')</nobr><br />'
      ..'<nobr>Author: ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')</nobr><br />'
      ..'<nobr>Ported by: ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)</nobr><br />'
      )
  else
    handle:write('</p>\n  <p class="error">'..fuse.error)
  end

  handle:write('</p></td>\n</tr>\n')

end

if currentCategory~='' then
  handle:write('</table>\n')
end


handle:close()
