local bmd = {}



-- A silly attempt to mimic bmd.readdir to make scripts using
-- this function work even if called not from within Fusion

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



function bmd.fileexists(filepath)
    local filehandle=io.open(filepath,"r")
    if filehandle~=nil then
        io.close(filehandle)
        return true
    end
    return false
 end


function bmd.createdir(dirname)
    os.execute("mkdir -p '" .. dirname.."'")
end


return bmd

