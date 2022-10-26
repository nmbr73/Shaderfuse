#!/usr/bin/env lua

package.path = package.path .. ';../Modules/Lua/?.lua'

bmd = require("Shadertoys/bmd")

require("Shadertoys/function_updateMarkdown")
updateMarkdown()


