#!/usr/bin/env lua

-- call from repository root directory as
-- lua Tools/Shell/print_latest.lua

package.path = package.path .. ';Tools/Modules/Lua/?.lua'

bmd = require("Shaderfuse/bmd")

-- require("os")
require("string")
require("Shaderfuse/util")
require("Shaderfuse/maintenance_functions")

-- require("Shaderfuse/Fuse")
local fuses = require("Shaderfuse/fuses")



repositorypath = get_repositorypath(repositorypath)
-- fuses.fetch(repositorypath..'/Shaders/','development')
fuses.fetch(repositorypath..'/docs/','development')

local latest = {}

for _, fuse in ipairs(fuses.list) do
  
  if fuse.Date then
    local y,m,d = fuse.Date:match("^([0-9][0-9][0-9][0-9])%-([0-9][0-9])%-([0-9][0-9])$")
    if y and m and d then
      
      local timestamp = os.time({ year = y, month = m, day = d, hour = 12, min = 30, sec = 00 })
      local timestruct = os.date("*t", timestamp)
      local us_week = tonumber(os.date("%U", timestamp))
      local day = timestruct.day
      local x = ({[1]="st",[2]="nd",[3]="rd"})[day%10] or "th"
      if day%100 >= 11 and day%100 <= 13 then x = "th" end

      fuse.latest_date = string.format("%d%s %s", day, x, os.date("%B", timestamp))

      table.insert(latest,fuse)
    end
  end
end

-- sort by date descending
table.sort(latest, function(a, b)
    return a.Date > b.Date
end)


for i, fuse in ipairs(latest) do

  stow = ""

  if fuse.Shadertoy.SOTW then
    stow = " (Shader of the Week)"
  end

  local suffix = fuse:hasGif() and ".gif" or ".png"
  print( ""
    .. "## ["..fuse.Shadertoy.Name.."]("..fuse.Category.."/"..fuse.Name..".md) ".. stow .."\n"
    .. "**"..fuse.latest_date.."**<br />"
    .. "*Shadertoy ID [".. fuse.Shadertoy.ID .."](https://www.shadertoy.com/view/"..fuse.Shadertoy.ID ..")*<br />"
    )
  print("[!["..fuse.Shadertoy.Name.."]("..fuse.Category.."/"..fuse.Name..suffix..")]("..fuse.Category.."/"..fuse.Name..".md)")
  print("")

  if i > 10 then
    break
  end
end
