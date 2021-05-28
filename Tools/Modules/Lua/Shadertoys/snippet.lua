local snippet={}


function snippet.read(path,marker)
                                                    ; assert(marker~=nil and marker~="")
  local handle=io.open(path..'Tools/Snippets/'..marker..".lua", "rb")  ; assert(handle)
  local content = handle:read("*all")
  handle:close()                                    ; assert(content~=nil and content~="")
                                                      assert(string.find(content, "-- >>> SCHNIPP::"..marker) ~= nil)
                                                      assert(string.find(content, "-- <<< SCHNAPP::"..marker) ~= nil)
  return content
end



function snippet.replace(txt,marker,snippet)

  if txt == nil then return nil end

  local mark_begin  = "-- >>> SCHNIPP::"..marker
  local mark_end    = "-- <<< SCHNAPP::"..marker

  local pos1 = string.find(txt, mark_begin )
  local pos2 = string.find(txt, mark_end )

  if pos1 == nil or pos2==nil then return nil end

  pos2 = pos2+string.len(mark_end)

  return
       string.sub(txt,1,pos1-1)
    .. snippet
    .. string.sub(txt,pos2)

end


return snippet
