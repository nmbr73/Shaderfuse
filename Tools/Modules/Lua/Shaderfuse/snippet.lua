--- To replace the marked code in Fuses.
--
-- This module loads some text snippeds from 'Tools/Snippets/' that
-- can be used to replace these in a fuse's source code.
--
--     -- load 'reactor' snippes:
--     snippet.init(user_config.pathToRepository,'reactor',false)
--     -- replace the code snippets in the string 'source':
--     source=snippet.replace(source)
--
-- @module snippet



-------------------------------------------------------------------------------------------------------------------------------------------
-- Local structure to manage the module's data.
--
-- @table snippet
-- @field Snippets contains the different text snippets loaded from the 'Tools/Snippets/' template files.
-- @field Begin the character sequence that marks the begin of a text block to be replaced.
-- @field End the character sequence that marks the end of a text block to be replaced.
--
local snippet={
  Snippets = {
    FUREGISTERCLASS = '',
    SHADERFUSECONTROLS = '',
  },
  Begin = '-- >>> SCHNIPP::',
  End   = '-- <<< SCHNAPP::',
}



-------------------------------------------------------------------------------------------------------------------------------------------
-- Load the text snippets to use.
--
-- All the snippet files have a *'.&lt;type&gt;.lua'* suffix. With the `type` parameter you can determine what set of snippets to load
-- e.g. 'development' to be used for the fuses in the repository, 'reactor' for the fuses code when delivered to reactor.
--
-- If `redoable` is set to `true` the `init()` function makes sure the the snippets themselfes contain the markers. Thereby when replacing
-- a text block should result in a file that again contains the markerts. If source and destination is the same file you probably want
-- to set `redoable` to `true`so you can redo the operation later with new/updated snippets. If you write from a source file (e.g. in
-- 'Shaders/') to a different (e.g. in Atom/) - in particular if that destination is not meant to be processed again, then you may not
-- need the markers to appear in that destination file.
--
-- @param[type=string] path The folder where the snippet files reside.
-- @param[type=string] type To determine the variant of snippets to use.
-- @param[type=bool,opt=true] redoable Set to true if the operation must result in a string with markers again.
--
function snippet.init(path,type,redoable)

  assert(path   ~= nil)
  assert(type   ~= nil)

  if redoable == nil then
    redoable=true
  end

  for marker, txt in pairs(snippet.Snippets) do

    local handle=io.open(path..'Tools/Snippets/'..marker..'.'..type..'.lua', "r")  ;

    if handle then
      snippet.Snippets[marker]=handle:read("*all")
      handle:close()
    else
      print("failed to open file '".. path..'Tools/Snippets/'..marker..'.'..type..'.lua' .."'")
    end

    local content=snippet.Snippets[marker]

    if content == nil or content == '' then
      print("no content for marker '"..marker.."', path '".. path .."', type '".. type .."'")
    end

    assert(content~=nil)
    assert(content~='')

    if redoable then
      assert(string.find(content, snippet.Begin ..marker) ~= nil)
      assert(string.find(content, snippet.End   ..marker) ~= nil)
    end

  end
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Replace the marked text blocks.
--
-- @param[type=string] source The full fuse's source code read into this string.
-- @return[type=string] The fuse's source code with the marked text blocks (if any) replaced by the snippets.
--
function snippet.replace(source)

  if source == nil then return nil end

  for marker, replacement in pairs(snippet.Snippets) do
    local mark_begin  = snippet.Begin ..marker
    local mark_end    = snippet.End   ..marker

    local pos1 = string.find(source, mark_begin )
    local pos2 = string.find(source, mark_end )

    if pos1 == nil or pos2==nil then return nil end

    pos2 = pos2+string.len(mark_end)

    source =
        string.sub(source,1,pos1-1)
      .. replacement
      .. string.sub(source,pos2)
  end

  return source
end



return snippet
