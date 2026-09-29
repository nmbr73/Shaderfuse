require("string")
require("Shaderfuse/util")
-- require("Shaderfuse/Fuse")
local fuses = require("Shaderfuse/fuses")


------------------------------------------------------------------------------
-- Generate the Shader of the Week markdown file.
--
-- @param repositorypath The path to the repository (optional).

function create_sotw_markdown(repositorypath)
  repositorypath = get_repositorypath(repositorypath)
  -- fuses.fetch(repositorypath..'/Shaders/','development')
  fuses.fetch(repositorypath..'/docs/','development')

  local sotw = io.open(repositorypath..'docs/Overview.md',"w")
  local readme   = io.open(repositorypath..'docs/Shaders.md',"w")

  if not(overview) or not(readme) then
    print("We have a Problem")
    return false -- os.exit(10)
  end

  local header=[[

  <!--                                                             -->
  <!--           THIS IS AN AUTOMATICALLY GENERATED FILE           -->
  <!--                                                             -->
  <!--                  D O   N O T   E D I T ! ! !                -->
  <!--                                                             -->
  <!--  ALL CHANGES WILL BE OVERWRITTEN WITHOUT ANY FURTHER NOTICE -->
  <!--                                                             -->


print('# Shader of the Week\n\n')

print([[
On the frontpage of [Shadertoy.com](https://www.shadertoy.com/) you'll find a "[Shader of the Week](https://www.shadertoy.com/playlist/week)".
[JiPi](Profiles/JiPi.md), in particular, has made it his personal hobby to implement as many of these Shaders of the Week as possible.
]])


]]
  overview:write(header)
  readme:write(header)
  -- local links=''
  -- for i,cat in ipairs(fuses.categories) do
  --   links=links..' · ['..cat..']('..cat..'/README.md)'
  -- end
  -- overview:write("[README](README.md) · **OVERVIEW**"..links.."\n\n")
  -- readme:write("**README** · [OVERVIEW](OVERVIEW.md)"..links.."\n\n")
  overview:write('# Shaders\n\n')
  readme:write('# Shaders\n\n')

  local readme_cat=nil
  local currentCategory=''
  local boom=0
  local okay=0

  for _, fuse in ipairs(fuses.list) do
    util.clr_error()
    if fuse.Category ~= currentCategory then -- new category
      if currentCategory~='' then
        overview:write('\n\n')
        if readme_cat~=nil then
          readme_cat:close()
          readme_cat=nil
        end

      end

      currentCategory=fuse.Category
      overview:write("\n\n## "..fuse.Category.." Shaders\n\n")
      -- readme:write('\n\n**['..fuse.Category..' Shaders]('..fuse.Category..'/README.md)**\n')
      readme:write('\n\n### ['..fuse.Category..' Shaders]('..fuse.Category..'/README.md)\n\n')
      readme_cat   = io.open(repositorypath..'docs/'..fuse.Category..'/README.md',"w")
      readme_cat:write(header)
      -- local links='[README](../README.md) · [OVERVIEW](../OVERVIEW.md)'
      -- for i,cat in ipairs(fuses.categories) do
      --     if cat==currentCategory then
      --       links=links..' · **'..cat..'**'
      --     else
      --       links=links..' · ['..cat..'](../'..cat..'/README.md)'
      --     end
      -- end
      -- readme_cat:write(links.."\n\n")
      readme_cat:write("# "..fuse.Category.." Shaders\n\n")

      local description_cat = io.open(repositorypath..'Shaders/'..fuse.Category..'/DESCRIPTION.md',"r")
      local description = ''

      if description_cat then
        description = description_cat:read "*a"
        description_cat:close()
      end

      if description ~= nil and description ~= '' then
        readme_cat:write(description.."\n\n")
      end

    end -- new category

    if fuse:hasErrors() or not fuse:isCompatible() then
      boom=boom+1
    else
      okay=okay+1
    end

    if readme_cat==nil then
      print("Okay '"..fuse.Name.."' causing some trouble!")
      print("Category is '"..fuse.Category.."'")
    end

    overview:write(
        ''
      ..'<img src="../'..fuse.Category..'/'..fuse.Name..'.png" align="left" width="320 height="180" />'
      ..'<strong><a href="../'..fuse.Category..'/'..fuse.Name..'/" style="font-size:larger; ">'..fuse.Name..'</a></strong> '..((not(fuse:hasErrors()) and fuse:isCompatible()) and '🍀' or '💥')..'<br />'
      )
    update_fuse_markdown_file(fuse)
    if (not(fuse:hasErrors())) then
      overview:write(
          '<span style="font-size:smaller; font-weight:bold; ">'.. fuse.Shadertoy.License ..'</span><br />'
          ..'Category: <a href="../'..fuse.Category..'/">'..fuse.Category..' Shader</a><br />'
          ..'Shadertoy: <a href="https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..'">'..fuse.Shadertoy.Name..'</a><br />'
        ..'Author: <a href="https://www.shadertoy.com/user/'..fuse.Shadertoy.Author..'">'..fuse.Shadertoy.Author..'</a><br />'
        ..'Ported by: <a href="../Profiles/'..fuse.Author..'">'..fuse.Author..'</a><br />&nbsp;<br />'
        ..'<a href="../'..fuse.Category..'/'..fuse.Name..'-Installer.lua" download><img alt="Download Installer" src="https://img.shields.io/static/v1?label=Download&message='..fuse.Name..'-Installer.lua&color=blue" /></a>\n'
        ..'<br clear="all" />\n'
        )
      readme:write('- ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) (Shadertoy ID ['..fuse.Shadertoy.ID..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..')) ported by ['..fuse.Author..'](Profiles/'..fuse.Author..'.md)\n')
      readme_cat:write('## **['..fuse.Name..']('..fuse.Name..'.md)**\nbased on ['..fuse.Shadertoy.Name..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..') written by ['..fuse.Shadertoy.Author..'](https://www.shadertoy.com/user/'..fuse.Shadertoy.Author..')<br />and ported to DaFusion by ['..fuse.Author..'](../Profiles/'..fuse.Author..'.md)\n\n')
    else
      -- overview:write(''..fuse:getErrorsHTML()..'</p><br clear="all" />\n')
      overview:write(
        'Category: <a href="../'..fuse.Category..'/">'..fuse.Category..' Shader</a><br />'
        ..'<br clear="all" />\n')
      readme:write('- ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) 💥\n')
      readme_cat:write('## **['..fuse.Name..']('..fuse.Name..'.md)** 💥\n- *'..fuse:getErrorText()..'*\n\n')
    end

    if util.has_error() then
      print("problem with fuse '".. fuse.Name .."': ".. util.get_error())
    end

    overview:write('\n')
  end

  if currentCategory~='' then
    overview:write('\n')
  end

  if okay > 0 then
    overview:write("🍀 "..okay.."\n\n")
  end

  if boom > 0 then
    overview:write("💥 "..boom.."\n\n")
  end

  if readme_cat~=nil then readme_cat:close() end
  overview:close()
  readme:close()
end


------------------------------------------------------------------------------
-- Generate the CSV file.
--
-- @param repositorypath The path to the repository (optional).

function create_csv(repositorypath)
  repositorypath = get_repositorypath(repositorypath)
  fuses.fetch(repositorypath..'/Shaders/','development')

  local csv      = io.open(repositorypath..'Shaders.csv',"w")
  if not(csv) then
    print("We have a Problem")
    return false -- os.exit(10)
  end

  csv:write("Shadertoy ID,Shader Autor,Shader Name,Category,Fuse Name,Ported by,Issue\n")
  for _, fuse in ipairs(fuses.list) do
    local info = ''
    if fuse:hasErrors() then
      info = fuse:getErrorText()
    else
      if fuse.Compatibility.Windows_CUDA and not fuse.Compatibility.macOS_Metal then
        info = "Windows only"
      else
        if not fuse.Compatibility.Windows_CUDA and fuse.Compatibility.macOS_Metal then
          info = "Mac only"
        else
          if not fuse.Compatibility.Windows_CUDA and not fuse.Compatibility.macOS_Metal then
            info = "no compatibility"
          end

        end

      end

    end

    csv:write(
        '"'.. fuse.Shadertoy.ID ..'",' ..
        '"'.. fuse.Shadertoy.Author ..'",' ..
        '"'.. fuse.Shadertoy.Name ..'",' ..
        '"'.. fuse.Category ..'",' ..
        '"'.. fuse.Name ..'",' ..
        '"'.. fuse.Author ..'",' ..
        '"'.. info ..'"\n'
        )
  end

  csv:close()
  return true
end
