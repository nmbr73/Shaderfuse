require("string")




function updateMarkdown()

 local user_config = require("Shadertoys/~user_config")
 local fuses       = require("Shadertoys/fuses")
 local image       = require("Shadertoys/image")


    -- print("update markdown files")
  fuses.fetch(user_config.pathToRepository..'Shaders/',true)


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

  local links=''

  for i,cat in ipairs(fuses.categories) do
    links=links..' · ['..cat..']('..cat..'/README.md)'
  end


  overview:write("[README](README.md) · **OVERVIEW**"..links.."\n\n")
  readme:write("**README** · [OVERVIEW](OVERVIEW.md)"..links.."\n\n")

  overview:write('# Shaders\n\n')
  readme:write('# Shaders\n\n')

  local readme_cat=nil

  local currentCategory=''

  local boom=0
  local okay=0

  for i, fuse in ipairs(fuses.list) do

    if fuse.file_category ~= currentCategory then

      if currentCategory~='' then
        overview:write('\n\n')
        if readme_cat~=nil then
          readme_cat:close()
          readme_cat=nil
        end
      end

      currentCategory=fuse.file_category



      overview:write("## "..fuse.file_category.." Shaders\n\n")

      readme:write('\n\n**['..fuse.file_category..' Shaders]('..fuse.file_category..'/README.md)**\n')

      readme_cat   = io.open(user_config.pathToRepository..'Shaders/'..fuse.file_category..'/README.md',"w")
      readme_cat:write(header)

      local links='[README](../README.md) · [OVERVIEW](../OVERVIEW.md)'

      for i,cat in ipairs(fuses.categories) do
          if cat==currentCategory then
            links=links..' · **'..cat..'**'
          else
            links=links..' · ['..cat..'](../'..cat..'/README.md)'
          end
      end

      readme_cat:write(links.."\n\n")
      readme_cat:write("# "..fuse.file_category.." Shaders\n\n")


      local description_cat = io.open(user_config.pathToRepository..'Shaders/'..fuse.file_category..'/DESCRIPTION.md',"r")
      local description = ''

      if description_cat then
        -- print("description found")
        description = description_cat:read "*a"
        description_cat:close()
      end

      if description ~= nil and description ~= '' then
        readme_cat:write(description.."\n\n")
      end

    end

    if fuse.error then
      boom=boom+1
    else
      okay=okay+1
    end

    if readme_cat==nil then
      print("Okay '"..fuse.file_fusename.."' causing some trouble!")
      print("Category is '"..fuse.file_category.."'")
    end


    overview:write(
        '\n'
      ..'!['..fuse.file_category..'/'..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'_320x180.png)\\\n'
      ..'Fuse: ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md) '..(not(fuse.error) and ':four_leaf_clover:' or ':boom:')..'\\\n'
      ..'Category: ['..fuse.file_category..']('..fuse.file_category..'/README.md)\\\n'
      )



    if (not(fuse.error)) then
      overview:write(
          'Shadertoy: ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')\\\n'
        ..'Author: ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')\\\n'
        ..'Ported by: ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)\n'
        )

      readme:write('- ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md) (Shadertoy ID ['..fuse.shadertoy_id..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..')) ported by ['..fuse.dctlfuse_author..'](../Site/Profiles/'..fuse.dctlfuse_author..'.md)\n')

      readme_cat:write('## **['..fuse.file_fusename..']('..fuse.file_fusename..'.md)**\nbased on ['..fuse.shadertoy_name..'](https://www.shadertoy.com/view/'..fuse.shadertoy_id..') written by ['..fuse.shadertoy_author..'](https://www.shadertoy.com/user/'..fuse.shadertoy_author..')<br />and ported to DaFusion by ['..fuse.dctlfuse_author..'](../../Site/Profiles/'..fuse.dctlfuse_author..'.md)\n\n')
    --print("Okay '"..fuse.file_fusename.."' ")
    else


      overview:write('**'..fuse.error..'**\n')

      readme:write('- ['..fuse.file_fusename..']('..fuse.file_category..'/'..fuse.file_fusename..'.md) :boom:\n')

      readme_cat:write('## **['..fuse.file_fusename..']('..fuse.file_fusename..'.md)** :boom:\n- *'..fuse.error..'*\n\n')

    end

    overview:write('\n')

  end

  if currentCategory~='' then
    overview:write('\n')
  end

  if okay > 0 then
    overview:write(":four_leaf_clover: "..okay.."\n\n")
  end

  if boom > 0 then
    overview:write(":boom: "..boom.."\n\n")
  end


  if readme_cat~=nil then readme_cat:close() end

  overview:close()
  readme:close()


end


