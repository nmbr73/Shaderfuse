--- Utilities
-- @module util

local P = {}

if _REQUIREDNAME == nil then
  util = P
else
  _G[_REQUIREDNAME] = P
end



------------------------------------------------------------------------------
-- The systems path separator.
--
-- Most probably either a slash ('/') on Unix'ish systems, or the infamous
-- backslash on Windows.

P.path_separator = package.config:sub(1,1)



------------------------------------------------------------------------------
-- Internatl (!) variable to hold an error.

P._error = nil


------------------------------------------------------------------------------
-- Set error message.
--
-- @param err The error message to set

function P.set_error(err)
  assert(err)
  if not P._error then
    P._error = err
  end
end


------------------------------------------------------------------------------
-- Reset error message (no errors).
--

function P.clr_error()
  P._error = nil
end


------------------------------------------------------------------------------
-- Check for an error.
--
-- @return true if set_error() had been called before

function P.has_error()
  return P._error ~= nil
end


------------------------------------------------------------------------------
-- Get error message.
--
-- @return String of the first error

function P.get_error()
  return P._error
end


------------------------------------------------------------------------------
-- Copy file.
--
-- @param from Source file path
-- @param to Destination file path
-- @return true if successful, false otherwise

function P.copy_file(from, to)
  local from_file = io.open(from, "rb")
  local to_file = io.open(to, "wb")

  if not from_file or not to_file then return false end

  local from_data = from_file:read("*all")
  to_file:write(from_data)

  from_file:close()
  to_file:close()

  return true
end


------------------------------------------------------------------------------
-- Iterator for sorted table keys.
--
-- Using pairs() in a for-loop traverses the table items in some random order.
-- This is an issue if you want for example to print the content of a dictionary
-- and expect this to result for the same data in the same output on multiple
-- calls of the script.
--
-- @param t The table to iterate over
-- @param f Optional sort function
-- @return Iterator function
-- @see https://www.lua.org/pil/19.3.html

function P.pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do
    table.insert(a, n)
  end
  table.sort(a, f)

  local i = 0
  return function()
    i = i + 1
    if a[i] == nil then return nil end
    return a[i], t[a[i]]
  end
end


------------------------------------------------------------------------------
-- Get hash and date of the last Git commit for a file.
--
-- Returns the full commit hash and the date in YYYY-MM-DD format.
--
-- @param path The path to the file
-- @param fname The filename
-- @return hash, date or nil on error

function P.last_commit(path, fname)
  local command = string.format("cd '%s' ; git log -n 1 --pretty=\"format:%%H %%cs\" -- '%s.fuse'", path, fname)
  local handle = io.popen(command)
  if not handle then
    util.set_error("failed to run 'git log'")
    return nil
  end

  local output = handle:read("*a")
  handle:close()

  local hash, date = output:match('^([0-9a-f]+) (20%d%d%-%d%d%-%d%d)%s*$')
  if not (hash and date) then
    util.set_error("git log does not match expected output: " .. output)
    return nil
  end

  return hash, date
end


------------------------------------------------------------------------------
-- Base64 decode data.
--
-- @param data A base64 encoded string
-- @return The decoded data or nil if input is nil

function P.base64_decode(data)
  if not data then return nil end
  local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  data = string.gsub(data, '[^' .. b .. '=]', '')
  return (data:gsub('.', function(x)
    if x == '=' then return '' end
    local r, f = '', (b:find(x) - 1)
    for i = 6, 1, -1 do
      r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
    end
    return r
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if #x ~= 8 then return '' end
    local c = 0
    for i = 1, 8 do
      c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0)
    end
    return string.char(c)
  end))
end


------------------------------------------------------------------------------
-- Base64 encode data.
--
-- @param data Some binary data
-- @return The data encoded in base64 or nil if input is nil

function P.base64_encode(data)
  if not data then return nil end
  local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  return ((data:gsub('.', function(x)
    local r, byte = '', x:byte()
    for i = 8, 1, -1 do
      r = r .. (byte % 2^i - byte % 2^(i - 1) > 0 and '1' or '0')
    end
    return r
  end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
    if #x < 6 then return '' end
    local c = 0
    for i = 1, 6 do
      c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0)
    end
    return b:sub(c + 1, c + 1)
  end) .. ({ '', '==', '=' })[#data % 3 + 1])
end




return P
