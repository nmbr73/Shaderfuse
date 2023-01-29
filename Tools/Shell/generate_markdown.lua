#!/usr/bin/env lua

package.path = package.path .. ';../Modules/Lua/?.lua'

bmd = require("Shaderfuse/bmd")

require("Shaderfuse/maintenance_functions")
create_markdown_files()
