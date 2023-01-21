require("string")




function updateMarkdown()

 local user_config = require("Shaderfuse/~user_config")
 local fuses       = require("Shaderfuse/fuses")
-- local image       = require("Shadertoys/image")


    -- print("update markdown files")
  fuses.fetch(user_config.pathToRepository..'Shaders/','development')


  bmd.createdir(user_config.pathToRepository..'docs')


  local overview = io.open(user_config.pathToRepository..'docs/OVERVIEW.md',"w")
  local readme   = io.open(user_config.pathToRepository..'docs/README.md',"w")
  local csv      = io.open(user_config.pathToRepository..'Shaders.csv',"w")



  if not(overview) or not(readme) or not(csv) then
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
  csv:write("Shadertoy ID,Shader Autor,Shader Name,Category,Fuse Name,Ported by,Issues\n")

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

    if fuse.Category ~= currentCategory then

      if currentCategory~='' then
        overview:write('\n\n')
        if readme_cat~=nil then
          readme_cat:close()
          readme_cat=nil
        end
      end

      currentCategory=fuse.Category



      overview:write("## "..fuse.Category.." Shaders\n\n")

      readme:write('\n\n**['..fuse.Category..' Shaders]('..fuse.Category..'/README.md)**\n')

      readme_cat   = io.open(user_config.pathToRepository..'Shaders/'..fuse.Category..'/README.md',"w")
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
      readme_cat:write("# "..fuse.Category.." Shaders\n\n")


      local description_cat = io.open(user_config.pathToRepository..'Shaders/'..fuse.Category..'/DESCRIPTION.md',"r")
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

    if fuse:hasErrors() then
      boom=boom+1
    else
      okay=okay+1
    end

    if readme_cat==nil then
      print("Okay '"..fuse.Name.."' causing some trouble!")
      print("Category is '"..fuse.Category.."'")
    end


    overview:write(
        '\n'
      ..'!['..fuse.Category..'/'..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'_320x180.png)\\\n'
      ..'Fuse: ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) '..(not(fuse:hasErrors()) and ':four_leaf_clover:' or ':boom:')..'\\\n'
      ..'Category: ['..fuse.Category..']('..fuse.Category..'/README.md)\\\n'
      )



    if (not(fuse:hasErrors())) then
      overview:write(
          'Shadertoy: ['..fuse.Shadertoy.Name..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..')\\\n'
        ..'Author: ['..fuse.Shadertoy.Author..'](https://www.shadertoy.com/user/'..fuse.Shadertoy.Author..')\\\n'
        ..'Ported by: ['..fuse.Author..'](../Site/Profiles/'..fuse.Author..'.md)\n'
        )

      readme:write('- ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) (Shadertoy ID ['..fuse.Shadertoy.ID..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..')) ported by ['..fuse.Author..'](../Site/Profiles/'..fuse.Author..'.md)\n')

      readme_cat:write('## **['..fuse.Name..']('..fuse.Name..'.md)**\nbased on ['..fuse.Shadertoy.Name..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..') written by ['..fuse.Shadertoy.Author..'](https://www.shadertoy.com/user/'..fuse.Shadertoy.Author..')<br />and ported to DaFusion by ['..fuse.Author..'](../../Site/Profiles/'..fuse.Author..'.md)\n\n')
    --print("Okay '"..fuse.Name.."' ")

--    Shadertoy ID,Shader Autor,Shader Name,Category,Fuse Name,Ported by,Issues
--    "ltsXDB","metabog","BumpyReflectingBalls","Abstract","BumpyReflectingBalls","JiPi",""

    else


      overview:write('**'..fuse:getErrorText()..'**\n')

      readme:write('- ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) :boom:\n')

      readme_cat:write('## **['..fuse.Name..']('..fuse.Name..'.md)** :boom:\n- *'..fuse:getErrorText()..'*\n\n')

    end

    csv:write(
        '"'.. fuse.Shadertoy.ID ..'",' ..
        '"'.. fuse.Shadertoy.Author ..'",' ..
        '"'.. fuse.Shadertoy.Name ..'",' ..
        '"'.. fuse.Category ..'",' ..
        '"'.. fuse.Name ..'",' ..
        '"'.. fuse.Author ..'",' ..
        '"'.. (not(fuse:hasErrors()) and '' or fuse:getErrorText()) ..'"\n'
    )

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
  csv:close()


end


