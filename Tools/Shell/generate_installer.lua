#!/usr/bin/env lua

package.path = package.path .. ';../Modules/Lua/?.lua'

bmd = require("Shaderfuse/bmd")

require("Shaderfuse/function_createInstaller")

code = installer_code("/Users/nmbr73/Projects/Shadertoys/Shaders/Wedding/Heartdemo.fuse")
if has_error() then
    print("ERROR: ".. get_error())
else
    print(code)
end


-- ---------------------------------------------------


function tprint(t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
          util.tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
  end

