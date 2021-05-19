require("string")

local user_config = require("Shadertoys/~user_config")
local fuses       = require("Shadertoys/fuses")

-- Ruins the Text: Planet shaders are shaders that generally render planets. The following tasks should be mentioned: surface texture, moving atmosphere, the use of bump maps or displacement for the surface texture. Rotations and movements in relation to the background or additional planets or suns and their throwing of light or shadow represent further challenges. The boundary between some blobs and planets is fluid

fuses.fetch(user_config.pathToRepository..'Shaders/',true)

-- print("go ...") ; dump(fuses) ; os.exit()

local overview = io.open(user_config.pathToRepository..'Shaders/OVERVIEW.md',"w")
local readme   = io.open(user_config.pathToRepository..'Shaders/README.md',"w")

if not(overview) or not(readme) then
  print("We have a Problem")
  os.exit(10)
end

--  handle:write(fuseSourceCode)

local header=[[

  <!--                                                             -->
  <!--           THIS IS AN AUTOMATICALLY GENERATED FILE           -->
  <!--                                                             -->
  <!--                  D O   N O T   E D I T ! ! !                -->
  <!--                                                             -->
  <!--  ALL CHANGES WILL BE OVERWRITTEN WITHOUT ANY FURTHER NOTICE -->
  <!--                                                             -->


]]

overview:write(header)
readme:write(header)

overview:write('# Shaders\n\n')
readme:write('# Shaders\n\n')

local readme_cat=nil

local currentCategory=''

local boom=0
local okay=0

for i, fuse in ipairs(fuses.list) do

  if fuse.file_category ~= currentCategory then

    if currentCategory~='' then
      overview:write('</table>\n\n')
      if readme_cat~=nil then
        readme_cat:close()
        readme_cat=nil
      end
    end

    currentCategory=fuse.file_category



    overview:write("## "..fuse.file_category.." Shaders\n\n<table>")

    readme:write('\n\n**['..fuse.file_category..' Shaders]('..fuse.file_category..'/)**\n')

    readme_cat   = io.open(user_config.pathToRepository..'Shaders/'..fuse.file_category..'/README.md',"w")
    readme_cat:write(header)
    readme_cat:write("# "..fuse.file_category.." Shaders\n\n")


  end

  if fuse.error then
    boom=boom+1
  else
    okay=okay+1
  end

  if readme_cat==nil then
    print("Okay '"..fuse.file_fusename.."' causing some trouble!")
    print("Categiry is '"..fuse.file_category.."'")
  end


  overview:write(
      '<tr>\n'
    ..'<td>'
    ..'<img src="'..fuse.file_category..'/'..fuse.file_fusename..'_320x180.png" alt="'..fuse.file_category..'/'..fuse.file_fusename..'" width="320" height="180" />'
    ..'</td>\n<td><p>\n\n'..(not(fuse.error) and ':four_leaf_clover:' or ':boom:')..'</p>\n<p>\n\n'
    ..'<nobr>Fuse: ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md)</nobr><br />\n'
    ..'<nobr>Category: ['..fuse.file_category..']('..fuse.file_category..'/OVERVIEW.md)</nobr><br />\n'
    )



  if (not(fuse.error)) then
    overview:write(
        '<nobr>Shadertoy: ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')</nobr><br />\n'
      ..'<nobr>Author: ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')</nobr><br />\n'
      ..'<nobr>Ported by: ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)</nobr><br />\n'
      )

    readme:write('- ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md) (Shadertoy ID ['..fuse.shadertoy_id..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')) ported by ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)\n')

    readme_cat:write('## **['..fuse.file_fusename..']('..fuse.file_fusename..'.md)**\nbased on ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..') written by ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')<br />and ported to DaFusion by ['..fuse.dctlfuse_author..'](....//Site/Profiles/'..fuse.dctlfuse_author..'.md)\n\n')
  else


    overview:write('</p><p style="color:red; font-weight:bold; ">'..fuse.error)

    readme:write('- ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md) :boom:\n')

    readme_cat:write('## **['..fuse.file_fusename..']('..fuse.file_fusename..'.md)** :boom:\n- *'..fuse.error..'*\n\n')

  end

  overview:write('</p>\n</td></tr>\n')

end

if currentCategory~='' then
  overview:write('</table>\n')
end

if okay > 0 then
  overview:write(":four_leaf_clover: "..okay.."<br />\n")
end

if boom > 0 then
  overview:write(":boom: "..boom.."<br />\n")
end


if readme_cat~=nil then readme_cat:close() end

overview:close()
readme:close()
