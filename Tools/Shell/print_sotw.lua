#!/usr/bin/env lua

-- call from repository root directory as
-- lua Tools/Shell/print_sotw.lua

package.path = package.path .. ';Tools/Modules/Lua/?.lua'

bmd = require("Shaderfuse/bmd")

-- require("os")
require("string")
require("Shaderfuse/util")
require("Shaderfuse/maintenance_functions")

-- require("Shaderfuse/Fuse")
local fuses = require("Shaderfuse/fuses")


--print('# Shader of the Week\n')
--
--print([[
--On the frontpage of [Shadertoy.com](https://www.shadertoy.com/) you'll find a "[Shader of the Week](https://www.shadertoy.com/playlist/week)".
--[JiPi](Profiles/JiPi.md), in particular, has made it his personal hobby to implement as many of these Shaders of the Week as possible.
--]])

repositorypath = get_repositorypath(repositorypath)
-- fuses.fetch(repositorypath..'/Shaders/','development')
fuses.fetch(repositorypath..'/docs/','development')

local sotw = {}

for _, fuse in ipairs(fuses.list) do
  
  if fuse.Shadertoy and fuse.Shadertoy.SOTW then
    local y,m,d = fuse.Shadertoy.SOTW:match("^([0-9][0-9][0-9][0-9])%-([0-9][0-9])%-([0-9][0-9])$")
    if y and m and d then
      
      local timestamp = os.time({ year = y, month = m, day = d, hour = 12, min = 30, sec = 00 })
      local timestruct = os.date("*t", timestamp)
      local us_week = tonumber(os.date("%U", timestamp))
      local day = timestruct.day
      local x = ({[1]="st",[2]="nd",[3]="rd"})[day%10] or "th"
      if day%100 >= 11 and day%100 <= 13 then x = "th" end

      -- fuse.date_str = string.format("CW %d: %d%s of %s, %d", us_week, day, x, os.date("%B", timestamp), timestruct.year)
      fuse.sotw_date = string.format("%d%s of %s %d", day, x, os.date("%B", timestamp), timestruct.year)
      fuse.sotw_year = timestruct.year

      table.insert(sotw,fuse)
    end
  end
end

-- sort by date descending
table.sort(sotw, function(a, b)
    return a.Shadertoy.SOTW > b.Shadertoy.SOTW
end)


year = ''
for _, fuse in ipairs(sotw) do
  if fuse.sotw_year ~= year then
    year = fuse.sotw_year
    print("## " .. year .. "\n")
  end

  local suffix = fuse:hasGif() and ".gif" or ".png"
  print("### "..fuse.sotw_date)
  print("#### ["..fuse.Shadertoy.Name.."]("..fuse.Category.."/"..fuse.Name..".md) (Shadertoy ID [".. fuse.Shadertoy.ID .."](https://www.shadertoy.com/view/"..fuse.Shadertoy.ID .."))")
  print("[!["..fuse.Shadertoy.Name.."]("..fuse.Category.."/"..fuse.Name..suffix..")]("..fuse.Category.."/"..fuse.Name..".md)")
  print("")
  --print('- ' .. fuse.date_str .. " / " .. fuse.Name .. " / " .. fuse.Category)
end
