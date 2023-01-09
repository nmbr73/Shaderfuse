--- Mock some simple bmd methods.
--
-- A silly attempt to mimic some basic bmd functions (readdir, fileexists, createdir) to
-- make scripts using these work, even if called not from within Fusion.
--
--    bmd = require("Shadertoys/bmd")
--    ...
--
-- @module bmd


local bmd = {}



-------------------------------------------------------------------------------------------------------------------------------------------
-- Mock the bmd readdir function.
--
function bmd.readdir(directory)

  local dir, file = directory:match'(.*/)(.*)'
  local handle = { Parent = dir, Pattern = file, }
  local command = ("find -H '%s' -name '".. file .."' -mindepth 1 -maxdepth 1"):format(dir)

  for i,d in ipairs({true, false}) do
    local pfile = assert(io.popen(command.." -type ".. (d and "d" or "f"), 'r'))
    local list = pfile:read('*a')
    pfile:close()
    for filename in string.gmatch(list, '[^\r\n]+') do
        dir, file = filename:match'(.*)/(.*)'
        table.insert(handle, { Name = file, IsDir = d, })
    end
  end

  return handle
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Mock the bmd fileexists function.
--
function bmd.fileexists(filepath)
    local filehandle=io.open(filepath,"r")
    if filehandle~=nil then
        io.close(filehandle)
        return true
    end
    return false
 end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Mock the bmd createdir function.
--
function bmd.createdir(dirname)
    os.execute("mkdir -p '" .. dirname.."'")
end



return bmd
