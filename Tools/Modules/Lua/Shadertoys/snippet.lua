local snippet={
  Snippets = {
    FUREGISTERCLASS = '',
    SHADERFUSECONTROLS = '',
  },
  Begin = '-- >>> SCHNIPP::',
  End   = '-- <<< SCHNAPP::',

}


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
    end

    local content=snippet.Snippets[marker]
    assert(content~=nil)
    assert(content~='')

    if redoable then
      assert(string.find(content, snippet.Begin ..marker) ~= nil)
      assert(string.find(content, snippet.End   ..marker) ~= nil)
    end

  end
end



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
