require("string")
require("Shaderfuse/util")
-- require("Shaderfuse/Fuse")
local fuses = require("Shaderfuse/fuses")



-------------------------------------------------------------------------------------------------------------------------------------------
-- Substitute placeholders in the installer template.
--
-- @param fuse The fuse the installer should be build for.
-- @param installer_code The the installer template source.
-- @param fuse_code The fuse source code that's meant to be installed by the installer code.
--
-- @return the installer source code.

function patch_installer_source(fuse,installer_code,fuse_code)

  if not installer_code then util.set_error("no installer_code for patch_installer_source()"); return nil end
  if not fuse_code then util.set_error("no fuse_code for patch_installer_source()"); return nil end

  installer_code = installer_code:gsub('{{> hash <}}',fuse.Commit.Hash)
  installer_code = installer_code:gsub('{{> hash15 <}}',string.sub(fuse.Commit.Hash,1,15))
  installer_code = installer_code:gsub('{{> version <}}',fuse.Commit.Version)
  installer_code = installer_code:gsub('{{> modified <}}',fuse.Commit.Date)
  installer_code = installer_code:gsub('{{> Fuse.Name <}}',fuse.Name)
  installer_code = installer_code:gsub('{{> Fuse.Author <}}',fuse.Author)
  installer_code = installer_code:gsub('{{> Fuse.AuthorURL <}}',fuse.Author)
  installer_code = installer_code:gsub('{{> Shadertoy.ID <}}',fuse.Shadertoy.ID)
  installer_code = installer_code:gsub('{{> Shadertoy.Name <}}',fuse.Shadertoy.Name)
  installer_code = installer_code:gsub('{{> Shadertoy.Author <}}',fuse.Shadertoy.Author)
  installer_code = installer_code:gsub('{{> Shadertoy.License <}}',fuse.Shadertoy.License)

  installer_code = installer_code:gsub('{{> thumbnail.data <}}',fuse.Thumbnail.Data)
  installer_code = installer_code:gsub('{{> fusecode.data <}}',util.base64_encode(fuse_code))

  installer_code = installer_code:gsub('{{> minilogo.width <}}',fuse.MiniLogo.Width)
  installer_code = installer_code:gsub('{{> minilogo.height <}}',fuse.MiniLogo.Height)
  installer_code = installer_code:gsub('{{> minilogo.image <}}',fuse.MiniLogo.Image)

  return installer_code
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Substitute elements in the fuse's code.
--
-- There are some 'devleopment only' constructs in the shader fuses that must replaced
-- for the final / stand-alone fuse as used by the installer and/or atom package.
--
-- @param fuse The fuse the sourceode comes from..
-- @param fuse_code The fuse's source code.
--
-- @return fuse source code without any ShaderFuse references.

function patch_fuse_source(fuse,fuse_code)

  if not fuse_code then util.set_error("no code for patch_fuse_source()"); return nil end

  local n

  fuse_code, n = fuse_code:gsub('\n%s*local%s+ShaderFuse%s*=%s*require%("Shaderfuse/ShaderFuse"%)%s*\n','\n',1)
  if n ~= 1 then util.set_error("failed to eliminate ShaderFuse require statement"); return nil end

  fuse_code, n = fuse_code:gsub('\n%s*ShaderFuse%.init%(%)%s*\n','\n',1)
  if n ~= 1 then util.set_error("failed to eliminate ShaderFuse init statement"); return nil end

  fuse_code, n = fuse_code:gsub('ShaderFuse.FuRegister.Name','"'.. fuse.FuRegister.Name ..'"',1)
  if n ~= 1 then util.set_error("failed to eliminate ShaderFuse FuRegister.Name "); return nil end

  local furegister_attributes = '\n'

  for key, value in util.pairsByKeys(fuse.FuRegister.Attributes) do
    if type(value) == 'boolean' then
      value = value and 'true' or 'false'
    else
      value = value:gsub('\\','\\\\')
      value = '"'..value..'"'
    end

    furegister_attributes = furegister_attributes .. '  '.. key ..' = ' .. value ..',\n'
  end

  fuse_code, n = fuse_code:gsub('ShaderFuse.FuRegister.Attributes%s*,',furegister_attributes,1)
  if n ~= 1 then util.set_error("failed to eliminate ShaderFuse FuRegister.Attributs"); return nil end

  local begin_create = [[
        self:AddInput('<p align="center"><a href="https://github.com/nmbr73/Shaderfuse"><img height="20" width="210" src="data:image/png;base64,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" /></a></p>',
          "ShaderfuseBranding", { IC_ControlPage = -1 , LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true, })]]

  fuse_code, n = fuse_code:gsub('\n%s*ShaderFuse%.begin_create%(%s*%)%s*\n',"\n"..begin_create.."\n",1)
  if n ~= 1 then util.set_error("failed to eliminate ShaderFuse.begin_create()"); return nil end

  local end_create =
       [[  ----- Info Tab]].."\n"
    .. [[  self:AddInput('<br /><p align="center">Shadertoy<br /><a href="https://www.shadertoy.com/view/]].. fuse.Shadertoy.ID ..[[" style="color:white; text-decoration:none; font-size:x-large; ">]]
        .. fuse.Shadertoy.Name ..[[</a><br />by <a href="https://www.shadertoy.com/user/]] .. fuse.Shadertoy.Author ..[[" style="color:#a0a060; text-decoration:none; ">]]
        .. fuse.Shadertoy.Author ..[[</a><br /><span style="color:#a06060; ">]]
        .. fuse.Shadertoy.License ..[[</span></p><p align="center">DCTLified and DaFused by <a href="]]
        .. (fuse.AuthorURL == '' and "https://nmbr73.github.io/Shaderfuse/" or fuse.AuthorURL)
        ..[[" style="color:#f0f060; text-decoration:none; ">]].. fuse.Author
        ..[[</a><br />Version: <a href="https://github.com/nmbr73/Shaderfuse/commit/]].. fuse.Commit.Hash .. [[" style color="color:#4060a0; ">]].. fuse.Commit.Version ..[[</a>&nbsp;/&nbsp;<span style="color:#ffffff; ">]].. fuse.Commit.Date .. [[</span></p><br />&nbsp;',]]
        ..[["ShaderfuseInfo", { ICS_ControlPage = "Info", IC_ControlPage = 1, LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true } )]] .."\n"
    .. [[  self:AddInput( "Fuse Info...", "ShaderfuseFuseInfoButton", { ICS_ControlPage = "Info", IC_ControlPage = 1, INPID_InputControl = "ButtonControl", INP_DoNotifyChanged = false, INP_External = false, BTNCS_Execute = 'bmd.openurl("]].. fuse.InfoURL .. [[")' })]] .."\n"
    .. [[  self:AddInput( "Shadertoy...", "ShaderfuseToyInfoButton", { ICS_ControlPage = "Info", IC_ControlPage = 1, INPID_InputControl = "ButtonControl", INP_DoNotifyChanged = false, INP_External = false, BTNCS_Execute = 'bmd.openurl("]].. fuse.Shadertoy.InfoURL ..[[")' })]] .."\n"
    .. [[  self:AddInput('<br /><p align="center"><img width="320" height="180" src="data:image/png;base64,]].. fuse.Thumbnail.Data ..[[" /></p>', "ShaderfuseThumbnail", { ICS_ControlPage = "Info", IC_ControlPage = 1, LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true } )]] .."\n"
    .. [[  self:AddInput('&nbsp;<br /><p>It seems that this version of the Fuse had been installed using a installer script. Please note that this means it has to be considered being an instable beta version!</p>', "ShaderfuseInstallInfo", { ICS_ControlPage = "Info", IC_ControlPage = 1, LINKID_DataType = "Text", INPID_InputControl = "LabelControl", LBLC_MultiLine = true, IC_NoLabel = true, IC_NoReset = true, INP_External = false, INP_Passive = true } )]] .."\n"

  fuse_code, n = fuse_code:gsub('\n%s*ShaderFuse%.end_create%(%s*%)%s*\n',"\n\n"..end_create.."\n",1)
  if n ~= 1 then util.set_error("failed to eliminate ShaderFuse.end_create()"); return nil end

  return fuse_code
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Read the fuse's thumbnail.
--

function fuse_thumbnail(fuse)

  local handle = io.open(fuse.DirName..'/'..fuse.Name..'.png', "rb")
  if not handle then util.set_error("failed to open "..fuse.DirName..'/'..fuse.Name..'.png'); return nil end
  local thumbnail_data = handle:read("*all")
  handle:close()

  return { Width = 320, Height = 180, Data = util.base64_encode(thumbnail_data), }
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Get the fuse author's mini logo.
--

function fuse_minilogo(fuse)

  if fuse.Author == 'JiPi' then
    return { Width = 47, Height = 24, Image = '<img width="47" height="24" src="data:image/png;base64,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" />', }
  elseif fuse.Author == 'nmbr73' then
    return { Width = 83, Height = 16, Image = '<img width="83" height="16" src="data:image/png;base64,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" />', }
  else
   return { Width = 0, Height = 0, Image = '' }
  end

end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Get the fuse's last commit hash and date.
--

function fuse_commit(fuse)

  local hash, date = util.last_commit(fuse.DirName, fuse.Name)
  if not hash or not date then return nil end

  return { Hash = hash, Date = date, Version = string.sub(hash,1,7) }
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Read the fuse's source code.
--

function fuse_source(fuse)

  local handle = io.open(fuse.DirName..'/'..fuse.Name..'.fuse', "r")
  if not handle then util.set_error("failed to open ".. fuse.DirName ..'/'..fuse.Name ..'.fuse'); return nil end
  local source_code = handle:read("*all")
  handle:close()

  return source_code
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Get the installer code template.
--

function installer_source()

  -- local handle = io.open("Installer-code.lua", "r")
  -- if not handle then util.set_error("failed to open Installer-code.lua"); return nil end
  -- local installer_code = handle:read("*all")
  -- handle:close()

  return util.base64_decode("CgoKLS0gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tCi0tICAgICAgICAgICAgIEEgVCBPIE0gQSBHIEkgQyBBIEwgWSAgIEcgRSBOIEUgUiBBIFQgRSBEICAgRiBJIEwgRQotLQotLSAgICAgICAgICAgICAgICAgICAgICAgLSAgIEQgTyAgIE4gTyBUICAgRSBEIEkgVCAgIC0KLS0KLS0gICAgICAgICAgICBXIEkgTCBMICAgQiBFICAgTyBWIEUgUiBXIFIgSSBUIFQgRSBOICAgVyBJIFQgSCBPIFUgVAotLSAgICAgICAgICAgICAgICAgICBBIE4gWSAgIEYgVSBSIFQgSCBFIFIgICBXIEEgUiBOIEkgTiBHCi0tCi0tICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLQotLSAgIEZ1c2U6ICAgIHt7PiBGdXNlLk5hbWUgPH19IGJ5IHt7PiBGdXNlLkF1dGhvciA8fX0KLS0gICBWZXJzaW9uOiB7ez4gdmVyc2lvbiA8fX0gKGJldGEpCi0tICAgICAgICAgICAgaHR0cHM6Ly9naXRodWIuY29tL25tYnI3My9TaGFkZXJ0b3lzL2NvbW1pdC97ez4gaGFzaDE1IDx9fSAuLi4KLS0gICBEYXRlOiAgICB7ez4gbW9kaWZpZWQgPH19Ci0tICAgU2hhZGVyOiAge3s+IFNoYWRlcnRveS5OYW1lIDx9fSAoaHR0cHM6Ly93d3cuc2hhZGVydG95LmNvbS92aWV3L3t7PiBTaGFkZXJ0b3kuSUQgPH19KQotLSAgICAgICAgICAgIGJ5IHt7PiBTaGFkZXJ0b3kuQXV0aG9yIDx9fSAoaHR0cHM6Ly93d3cuc2hhZGVydG95LmNvbS91c2VyL3t7PiBTaGFkZXJ0b3kuQXV0aG9yIDx9fSkKLS0gICBMaWNlbnNlOiB7ez4gU2hhZGVydG95LkxpY2Vuc2UgPH19Ci0tCi0tICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotLQotLSAgIFRoaXMgaXMgYW4gaW5zdGFsbGVyIGZpbGUgZm9yIEJsYWNrbWFnaWMncyBEYVZpbmNpIFJlc29sdmUgYW5kL29yIEZ1c2lvbgotLSAgIGFwcGxpY2F0aW9uLiBTZWUgaHR0cHM6Ly9naXRodWIuY29tL25tYnI3My9TaGFkZXJmdXNlIGZvciBjb250ZXh0LiBJZiB5b3UKLS0gICBhcmUgdmVyeSBicmF2ZSwgb3Igc2ltcGx5IGNvbXBsZXRlbHkgdGlyZWQgb2YgbGlmZSwgdGhlbiB5b3UgY2FuIGRyYWcgYW5kCi0tICAgZHJvcCB0aGlzIGZpbGUgb250byB5b3VyIEZ1c2lvbiBjb21wb3NpdGlvbidzIHdvcmtpbmcgYXJlYS4gR29vZCBsdWNrIQotLQotLSAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCgpsb2NhbCB1aSAgICAgICAgICAgID0gZnUuVUlNYW5hZ2VyCmxvY2FsIHVpZGlzcGF0Y2hlciAgPSBibWQuVUlEaXNwYXRjaGVyKHVpKQoKCgpmdW5jdGlvbiBkZWMoZGF0YSkKICAgIGxvY2FsIGI9J0FCQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXowMTIzNDU2Nzg5Ky8nCiAgICBkYXRhID0gc3RyaW5nLmdzdWIoZGF0YSwgJ1teJy4uYi4uJz1dJywgJycpCiAgICByZXR1cm4gKGRhdGE6Z3N1YignLicsIGZ1bmN0aW9uKHgpCiAgICAgICAgaWYgKHggPT0gJz0nKSB0aGVuIHJldHVybiAnJyBlbmQKICAgICAgICBsb2NhbCByLGY9JycsKGI6ZmluZCh4KS0xKQogICAgICAgIGZvciBpPTYsMSwtMSBkbyByPXIuLihmJTJeaS1mJTJeKGktMSk+MCBhbmQgJzEnIG9yICcwJykgZW5kCiAgICAgICAgcmV0dXJuIHI7CiAgICBlbmQpOmdzdWIoJyVkJWQlZD8lZD8lZD8lZD8lZD8lZD8nLCBmdW5jdGlvbih4KQogICAgICAgIGlmICgjeCB+PSA4KSB0aGVuIHJldHVybiAnJyBlbmQKICAgICAgICBsb2NhbCBjPTAKICAgICAgICBmb3IgaT0xLDggZG8gYz1jKyh4OnN1YihpLGkpPT0nMScgYW5kIDJeKDgtaSkgb3IgMCkgZW5kCiAgICAgICAgcmV0dXJuIHN0cmluZy5jaGFyKGMpCiAgICBlbmQpKQplbmQKCgoKZnVuY3Rpb24gZmlsZV9leGlzdHMocGF0aCwgZmlsZSkKCiAgICBhc3NlcnQocGF0aH49bmlsIGFuZCBwYXRofj0nJykKICAgIGFzc2VydChmaWxlfj1uaWwgYW5kIGZpbGV+PScnKQoKICAgIGxvY2FsIGYgPSBpby5vcGVuKHBhdGguLmZpbGUsInIiKQogICAgaWYgZiB+PSBuaWwgdGhlbgogICAgICAgIGlvLmNsb3NlKGYpCiAgICAgICAgcmV0dXJuIHRydWUKICAgIGVuZAoKICAgIHJldHVybiBmYWxzZTsKZW5kCgoKCmZ1bmN0aW9uIEluc3RhbGxXaW5kb3coKQoKICAgIGxvY2FsIGZ1c2VGaWxlRXhpc3RzID0gZmlsZV9leGlzdHMoZnVzaW9uOk1hcFBhdGgoJ0Z1c2VzOi9TaGFkZXJmdXNlX2JldGEnKSwgJ3t7PiBTaGFkZXJ0b3kuSUQgPH19X2IuZnVzZScpCgogICAgbG9jYWwgaW5zdGFsbFdpbmRvdyA9IHVpZGlzcGF0Y2hlcjpBZGRXaW5kb3coewogICAgICAgIElEID0gJ0luc3RhbGxXaW5kb3cnLAogICAgICAgIFdpbmRvd1RpdGxlID0gJ3t7PiBGdXNlLk5hbWUgPH19IEluc3RhbGxlcicsCiAgICAgICAgR2VvbWV0cnkgPSB7MTAwLCAxMDAsIDEwMjQsIDI3MH0sCiAgICAgICAgU3BhY2luZyA9IDEwLAoKICAgICAgICB1aTpWR3JvdXAgewoKICAgICAgICAgICAgSUQgPSAncm9vdCcsCgogICAgICAgICAgICB1aTpIR3JvdXAgewogICAgICAgICAgICAgICAgdWk6TGFiZWwgewogICAgICAgICAgICAgICAgICAgIElEID0gInRodW1ibmFpbCIsIFdvcmRXcmFwID0gZmFsc2UsIFdlaWdodCA9IDAsCiAgICAgICAgICAgICAgICAgICAgTWluaW11bVNpemUgPSB7MzIwLCAxODB9LCBSZWFkT25seSA9IHRydWUsIEZsYXQgPSB0cnVlLAogICAgICAgICAgICAgICAgICAgIEFsaWdubWVudCA9IHsgQWxpZ25IQ2VudGVyID0gZmFsc2UsIEFsaWduVG9wID0gdHJ1ZSwgfSwKICAgICAgICAgICAgICAgICAgICBUZXh0ID0gJzxpbWcgd2lkdGg9IjMyMCIgaGVpZ2h0PSIxODAiIHNyYz0iZGF0YTppbWFnZS9wbmc7YmFzZTY0LHt7PiB0aHVtYm5haWwuZGF0YSA8fX0iIC8+JywKICAgICAgICAgICAgICAgIH0sCgogICAgICAgICAgICAgICAgdWk6SEdhcCgyMCksCgogICAgICAgICAgICAgICAgdWk6TGFiZWwgewogICAgICAgICAgICAgICAgICAgIElEID0gJ3RleHQnLCBXb3JkV3JhcCA9IHRydWUsIFdlaWdodCA9IDIuMCwKICAgICAgICAgICAgICAgICAgICBPcGVuRXh0ZXJuYWxMaW5rcyA9IHRydWUsCiAgICAgICAgICAgICAgICAgICAgQWxpZ25tZW50ID0geyBBbGlnbkhDZW50ZXIgPSBmYWxzZSwgQWxpZ25WQ2VudGVyID0gZmFsc2UsIH0sCgogICAgICAgICAgICAgICAgICAgIFRleHQgPSBbWwogICAgICAgICAgICAgICAgICAgICAgICA8aDIgc3R5bGU9ImNvbG9yOiNlZmJkNzg7ICI+V2VsY29tZSB0byB0aGUge3s+IEZ1c2UuTmFtZSA8fX0gU2V0dXA8L2gyPgogICAgICAgICAgICAgICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1zaXplOmxhcmdlOyBjb2xvcjojZmZmZmZmOyAiPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGEgaHJlZj0iaHR0cHM6Ly93d3cuc2hhZGVydG95LmNvbS92aWV3L3t7PiBTaGFkZXJ0b3kuSUQgPH19IiBzdHlsZT0iY29sb3I6cmdiKDEzOSwxNTUsMjE2KTsgdGV4dC1kZWNvcmF0aW9uOm5vbmU7ICI+e3s+IFNoYWRlcnRveS5OYW1lIDx9fTwvYT4gY3JlYXRlZCBieQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGEgaHJlZj0iaHR0cHM6Ly93d3cuc2hhZGVydG95LmNvbS91c2VyL3t7PiBTaGFkZXJ0b3kuQXV0aG9yIDx9fSIgc3R5bGU9ImNvbG9yOnJnYigxMzksMTU1LDIxNik7IHRleHQtZGVjb3JhdGlvbjpub25lOyAiPnt7PiBTaGFkZXJ0b3kuQXV0aG9yIDx9fTwvYT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuZCBwb3J0ZWQgYnkgPGEgaHJlZj0ie3s+IEZ1c2UuQXV0aG9yVVJMIDx9fSIgc3R5bGU9ImNvbG9yOnJnYigxMzksMTU1LDIxNik7IHRleHQtZGVjb3JhdGlvbjpub25lOyAiPnt7PiBGdXNlLkF1dGhvciA8fX08L2E+PGJyIC8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8c3BhbiBzdHlsZT0iY29sb3I6Z3JheTsgZm9udC1zaXplOnNtYWxsOyAie3s+IFNoYWRlcnRveS5MaWNlbnNlIDx9fSZuYnNwOzwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICAgPC9wPgogICAgICAgICAgICAgICAgICAgICAgICA8cD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRoaXMgc2NyaXB0IHdpbGwgaW5zdGFsbCAnU2hhZGVyZnVzZV9iZXRhL3t7PiBTaGFkZXJ0b3kuSUQgPH19X2IuZnVzZScgb24geW91ciBjb21wdXRlci48YnIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRISVMgSVMgQVQgWU9VUiBPV04gUklTSyBBTkQgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCE8YnIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIENsaWNrICdDYW5jZWwnIHRvIGV4aXQgdGhlIHNldHVwLgogICAgICAgICAgICAgICAgICAgICAgICA8L3A+CiAgICAgICAgICAgICAgICAgICAgICAgIDxwIHN0eWxlPSJjb2xvcjojZmZmZmZmOyAiPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgVmlzaXQgdXMgb24gPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL25tYnI3My9TaGFkZXJ0b3lzIiBzdHlsZT0iY29sb3I6IHJnYigxMzksMTU1LDIxNik7IHRleHQtZGVjb3JhdGlvbjpub25lOyAiPkdpdEh1YjwvYT4gZm9yIG1vcmUgY3V0ZSBsaXR0bGUgU2hhZGVyRnVzZXMhCiAgICAgICAgICAgICAgICAgICAgICAgIDwvcD4KICAgICAgICAgICAgICAgICAgICAgICAgXV0KICAgICAgICAgICAgICAgICAgICAgICAgLi4oZnVzZUZpbGVFeGlzdHMgYW5kIFtbPHAgYWxpZ249ImNlbnRlciI+PHNwYW4gc3R5bGU9ImNvbG9yOiNmZmZmZmY7ICI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29sb3I6I2ZmMDAwMDsgIj4mbmJzcDtBVFRFTlRJT04hJm5ic3A7PC9zcGFuPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiMwMDAwMDA7ICI+Jm5ic3A7RnVzZSBhbHJlYWR5IGV4aXN0cyBhbmQgd2lsbCBiZSBkZWxldGVkIHJlc3AuIG92ZXJ3cml0dGVuISZuYnNwOzwvc3Bhbj48L3NwYW4+PC9wPl1dIG9yICcnKSwKICAgICAgICAgICAgICAgIH0sCiAgICAgICAgICAgIH0sCgogICAgICAgICAgICB1aTpMYWJlbCB7IFdlaWdodCA9IDAsIElEID0gJ2hyJywgVGV4dD0nPGhyIC8+JywgfSwKCiAgICAgICAgICAgIHVpOkhHcm91cHsKCiAgICAgICAgICAgICAgICBXZWlnaHQgPSAwLAoKICAgICAgICAgICAgICAgIHVpOkhHYXAoNSksCgogICAgICAgICAgICAgICAgdWk6TGFiZWwgewogICAgICAgICAgICAgICAgICAgIElEID0gImxvZ28iLCBXb3JkV3JhcCA9IGZhbHNlLCBXZWlnaHQgPSAwLAogICAgICAgICAgICAgICAgICAgIE1pbmltdW1TaXplID0geyB7ez4gbWluaWxvZ28ud2lkdGggPH19LCB7ez4gbWluaWxvZ28uaGVpZ2h0IDx9fSB9LAogICAgICAgICAgICAgICAgICAgIFJlYWRPbmx5ID0gdHJ1ZSwgRmxhdCA9IHRydWUsCiAgICAgICAgICAgICAgICAgICAgQWxpZ25tZW50ID0geyBBbGlnbkhDZW50ZXIgPSBmYWxzZSwgQWxpZ25Ub3AgPSB0cnVlLCB9LAogICAgICAgICAgICAgICAgICAgIFRleHQgPSAne3s+IG1pbmlsb2dvLmltYWdlIDx9fScsCiAgICAgICAgICAgICAgICB9LAoKICAgICAgICAgICAgICAgIHVpOkhHYXAoMCwgMi4wKSwKCiAgICAgICAgICAgICAgICB1aTpCdXR0b257ICBJRCA9ICJVbmluc3RhbGwiLCBUZXh0ID0gIlVuaW5zdGFsbCIsIEhpZGRlbiA9IChub3QgZnVzZUZpbGVFeGlzdHMpLCAgfSwKICAgICAgICAgICAgICAgIHVpOkJ1dHRvbnsgIElEID0gIkluc3RhbGwiLCBUZXh0ID0gKGZ1c2VGaWxlRXhpc3RzIGFuZCAiT3ZlcndyaXRlIiBvciAiSW5zdGFsbCIpLCAgICB9LAogICAgICAgICAgICAgICAgdWk6QnV0dG9ueyAgSUQgPSAiQ2FuY2VsIiwgIFRleHQgPSAiQ2FuY2VsIiwgIH0sCiAgICAgICAgICAgIH0sCiAgICAgICAgfSwKICAgIH0pCgogICAgZnVuY3Rpb24gaW5zdGFsbFdpbmRvdy5Pbi5Vbmluc3RhbGwuQ2xpY2tlZChldikKICAgICAgICBpbnN0YWxsV2luZG93OkhpZGUoKQogICAgICAgIHVuaW5zdGFsbF9hY3Rpb24oKQogICAgZW5kCgogICAgZnVuY3Rpb24gaW5zdGFsbFdpbmRvdy5Pbi5JbnN0YWxsLkNsaWNrZWQoZXYpCiAgICAgICAgaW5zdGFsbFdpbmRvdzpIaWRlKCkKICAgICAgICBpbnN0YWxsX2FjdGlvbihmdXNlRmlsZUV4aXN0cykKICAgIGVuZAoKICAgIGZ1bmN0aW9uIGluc3RhbGxXaW5kb3cuT24uSW5zdGFsbFdpbmRvdy5DbG9zZShldikKICAgICAgICB1aWRpc3BhdGNoZXI6RXhpdExvb3AoKQogICAgZW5kCgogICAgZnVuY3Rpb24gaW5zdGFsbFdpbmRvdy5Pbi5DYW5jZWwuQ2xpY2tlZChldikKICAgICAgICBpbnN0YWxsV2luZG93OkhpZGUoKQogICAgICAgIHVpZGlzcGF0Y2hlcjpFeGl0TG9vcCgpCiAgICBlbmQKCiAgICByZXR1cm4gaW5zdGFsbFdpbmRvdwplbmQKCgoKZnVuY3Rpb24gRW5kU2NyZWVuKHRleHQpCgogICAgbG9jYWwgZW5kU2NyZWVuID0gdWlkaXNwYXRjaGVyOkFkZFdpbmRvdyh7CiAgICAgICAgSUQgPSAnRW5kU2NyZWVuJywKICAgICAgICBXaW5kb3dUaXRsZSA9ICd7ez4gRnVzZS5OYW1lIDx9fSBJbnN0YWxsZWQnLAogICAgICAgIEdlb21ldHJ5ID0gezMwMCwgMTAwLCA2NDAsIDI3MH0sCgogICAgICAgIHVpOlZHcm91cHsKICAgICAgICAgICAgSUQgPSAncm9vdCcsCgogICAgICAgICAgICB1aTpMYWJlbHsKICAgICAgICAgICAgICAgIFdlaWdodCA9IDEuMCwgSUQgPSAnRmluYWxUZXh0TGFiZWwnLAogICAgICAgICAgICAgICAgVGV4dCA9IHRleHQgLi4gJzxwPnt7PiBtaW5pbG9nby5pbWFnZSA8fX08L3A+JywKICAgICAgICAgICAgICAgIEFsaWdubWVudCA9IHsgQWxpZ25IQ2VudGVyID0gdHJ1ZSwgQWxpZ25WVG9wID0gdHJ1ZSwgfSwKICAgICAgICAgICAgICAgIFdvcmRXcmFwID0gdHJ1ZSwKICAgICAgICAgICAgfSwKCiAgICAgICAgICAgIHVpOkhHcm91cHsKICAgICAgICAgICAgICAgIFdlaWdodCA9IDAsCiAgICAgICAgICAgICAgICB1aTpIR2FwKDAsIDIuMCksCiAgICAgICAgICAgICAgICB1aTpCdXR0b257IFdlaWdodCA9IDAuMSwgSUQgPSAiT2theSIsIFRleHQgPSAiT2theSIsIH0sCiAgICAgICAgICAgICAgICB1aTpIR2FwKDAsIDIuMCksCiAgICAgICAgICAgIH0sCiAgICAgICAgfSwKICAgIH0pCgogIGZ1bmN0aW9uIGVuZFNjcmVlbi5Pbi5FbmRTY3JlZW4uQ2xvc2UoZXYpCiAgICAgIHVpZGlzcGF0Y2hlcjpFeGl0TG9vcCgpCiAgZW5kCgogIGZ1bmN0aW9uIGVuZFNjcmVlbi5Pbi5Pa2F5LkNsaWNrZWQoZXYpCiAgICBlbmRTY3JlZW46SGlkZSgpCiAgICB1aWRpc3BhdGNoZXI6RXhpdExvb3AoKQogIGVuZAoKICByZXR1cm4gZW5kU2NyZWVuCmVuZAoKCgpmdW5jdGlvbiB3cml0ZV9mdXNlKCkKCiAgICBsb2NhbCBmID0gaW8ub3BlbihmdXNpb246TWFwUGF0aCgnRnVzZXM6L1NoYWRlcmZ1c2VfYmV0YS97ez4gU2hhZGVydG95LklEIDx9fV9iLmZ1c2UnKSwid2IiKQoKICAgIGlmIG5vdCBmIHRoZW4gcmV0dXJuIGZhbHNlIGVuZAoKICAgIGY6d3JpdGUoZGVjKCJ7ez4gZnVzZWNvZGUuZGF0YSA8fX0iKSkKICAgIGY6Y2xvc2UoKQoKICAgIGxvY2FsIHQgPSBpby5vcGVuKGZ1c2lvbjpNYXBQYXRoKCdGdXNlczovU2hhZGVyZnVzZV9iZXRhL3t7PiBTaGFkZXJ0b3kuSUQgPH19X2IucG5nJyksIndiIikKCiAgICBpZiBub3QgdCB0aGVuIHJldHVybiBmYWxzZSBlbmQKCiAgICB0OndyaXRlKGRlYygie3s+IHRodW1ibmFpbC5kYXRhIDx9fSIpKQogICAgdDpjbG9zZSgpCgogICAgcmV0dXJuIHRydWUKZW5kCgoKCmZ1bmN0aW9uIGluc3RhbGxfYWN0aW9uKG92ZXJ3cml0ZSkKCiAgICBsb2NhbCB0ZXh0ID0gJycKCiAgICBpZiBub3Qgb3ZlcndyaXRlIHRoZW4KICAgICAgICBibWQuY3JlYXRlZGlyKGZ1c2lvbjpNYXBQYXRoKCdGdXNlczovU2hhZGVyZnVzZV9iZXRhJykpCiAgICBlbmQKCiAgICBpZiB3cml0ZV9mdXNlKCkgdGhlbgoKICAgICAgICBpZiBub3Qgb3ZlcndyaXRlIHRoZW4KICAgICAgICAgICAgdGV4dCA9IFtbCiAgICAgICAgICAgICAgICA8aDI+SW5zdGFsbGF0aW9uIG9mIDxzcGFuIHN0eWxlPSJjb2xvcjojZmZmZmZmOyAiPnt7PiBGdXNlLk5hbWUgPH19PC9zcGFuPiAoaG9wZWZ1bGx5KSBjb21wbGV0ZWQ8L2gyPgogICAgICAgICAgICAgICAgPHA+CiAgICAgICAgICAgICAgICAgICAgSW4gb3JkZXIgdG8gdXNlIHRoZSBuZXdseSBpbnN0YWxsZWQgZnVzZSAoYWthIHRvb2w7IGtpbmQgb2YgYSBwbHVnLWluKSB5b3Ugd2lsbCBuZWVkIHRvIHJlc3RhcnQgRGFWaW5jaSBSZXNvbHZlIC8gRnVzaW9uLgogICAgICAgICAgICAgICAgPC9wPgogICAgICAgICAgICAgICAgPHA+CiAgICAgICAgICAgICAgICAgICAgVGhlbiBnbyBpbnRvIHlvdXIgRnVzaW9uIGNvbXBvc2l0aW9uIHdvcmtzcGFjZSwgc21hc2ggdGhlIFwnU2hpZnQrU3BhY2VcJyBzaG9ydGN1dCBhbmQgc2VhcmNoIGZvciAie3s+IEZ1c2UuTmFtZSA8fX0iCiAgICAgICAgICAgICAgICAgICAgdG8gYWRkIHRoaXMgdHlwZSBvZiBub2RlIC0gYW5kIHRoZW4gLi4uCiAgICAgICAgICAgICAgICA8L3A+CiAgICAgICAgICAgICAgICA8cCBzdHlsZT0iY29sb3I6I2ZmZmZmZjsgIj5IYXZlIEZ1biE8L3A+CiAgICAgICAgICAgIF1dCiAgICAgICAgZWxzZQogICAgICAgICAgICB0ZXh0ID0gW1sKICAgICAgICAgICAgICAgIDxoMj5VcGRhdGUgb2YgPHNwYW4gc3R5bGU9ImNvbG9yOiNmZmZmZmY7ICI+e3s+IEZ1c2UuTmFtZSA8fX08L3NwYW4+IChob3BlZnVsbHkpIGRvbmU8L2gyPgogICAgICAgICAgICAgICAgPHA+CiAgICAgICAgICAgICAgICAgICAgQXMgeW91IGFscmVhZHkgaGFkIHRoaXMgRnVzZSBpbnN0YWxsZWQsIHlvdSBtYXkgbm90IG5lZWQgdG8gcmVzdGFydCB0aGUgYXBwbGljYXRpb24uIEJ1dCBjaGFuY2VzIGFyZSwKICAgICAgICAgICAgICAgICAgICB0aGF0IHlvdSBoYXZlIGp1c3Qgb3ZlcndyaXR0ZW4gdGhlIHNhbWUgdmVyc2lvbiBhbmQgd2lsbCBub3QgZmluZCBhbnl0aGluZyBuZXcuCiAgICAgICAgICAgICAgICA8L3A+CiAgICAgICAgICAgICAgICA8cD4KICAgICAgICAgICAgICAgICAgICBIb3dldmVyLCBqdXN0IGFkZCBhICJ7ez4gRnVzZS5OYW1lIDx9fSIgbm9kZSB0byB5b3VyIGNvbXBvc2l0aW9uIHRvIGNoZWNrIGl0IG91dCAtIGFuZCB0aGVuIC4uLgogICAgICAgICAgICAgICAgPC9wPgogICAgICAgICAgICAgICAgPHAgc3R5bGU9ImNvbG9yOiNmZmZmZmY7ICI+RW5qb3khPC9wPgogICAgICAgICAgICBdXQogICAgICAgIGVuZAoKICAgIGVsc2UKCiAgICAgICAgdGV4dCA9IFtbCiAgICAgICAgICAgIDxoMj5JbnN0YWxsYXRpb24gb2YgPHNwYW4gc3R5bGU9ImNvbG9yOiNmZmZmZmY7ICI+e3s+IEZ1c2UuTmFtZSA8fX08L3NwYW4+IGZhaWxlZCE8L2gyPgogICAgICAgICAgICA8cD4KICAgICAgICAgICAgICAgIFRyaWVkIHRvIHdyaXRlICd7ez4gU2hhZGVydG95LklEIDx9fV9iLmZ1c2UnIGFuZCAne3s+IFNoYWRlcnRveS5JRCA8fX1fYi5wbmcnIGZpbGVzCiAgICAgICAgICAgICAgICBpbnRvIHRoZSAnU2hhZGVyZnVzZV9iZXRhJyBzdWJmb2xkZXIgb2YgeW91ciAnRnVzZXMnIGRpcmVjdG9yeSwgYnV0IC4uLgogICAgICAgICAgICA8aDIgc3R5bGU9ImNvbG9yOiNmZjAwMDA7ICI+U29tZXRoaW5nIHdlbnQgdGVycmlibHkgd3JvbmchPC9oMj4KICAgICAgICAgICAgPHAgc3R5bGU9ImNvbG9yOiNmZmZmZmY7ICI+RGFuZyE8L3A+CiAgICAgICAgXV0KCiAgICBlbmQKCiAgICBsb2NhbCBlbmRTY3JlZW4gPSBFbmRTY3JlZW4odGV4dCkKICAgIGVuZFNjcmVlbjpTaG93KCkKZW5kCgoKCmZ1bmN0aW9uIHVuaW5zdGFsbF9hY3Rpb24oKQoKICAgIGxvY2FsIGZ1c2VmaWxlcGF0aCA9IGZ1c2lvbjpNYXBQYXRoKCdGdXNlczovU2hhZGVyZnVzZV9iZXRhL3t7PiBTaGFkZXJ0b3kuSUQgPH19X2IuZnVzZScpCiAgICBsb2NhbCB0aHVtYmZpbGVwYXRoID0gZnVzaW9uOk1hcFBhdGgoJ0Z1c2VzOi9TaGFkZXJmdXNlX2JldGEve3s+IFNoYWRlcnRveS5JRCA8fX1fYi5wbmcnKQoKICAgIG9zLnJlbW92ZShmdXNlZmlsZXBhdGgpCiAgICBvcy5yZW1vdmUodGh1bWJmaWxlcGF0aCkKCiAgICBsb2NhbCB0ZXh0ID0gW1sKICAgICAgICA8aDI+PHNwYW4gc3R5bGU9ImNvbG9yOiNmZmZmZmY7ICI+e3s+IEZ1c2UuTmFtZSA8fX08L3NwYW4+IGhhcyAoaG9wZWZ1bGx5KSBiZWVuIDxzcGFuIHN0eWxlPSJjb2xvcjojZmYwMDAwOyAiPnVuaW5zdGFsbGVkPC9zcGFuPjwvaDI+CiAgICAgICAgPHA+CiAgICAgICAgICAgIFRoaXMgc2hvdWxkIGhhdmUgcmVtb3ZlZCB0aGUgJ3t7PiBTaGFkZXJ0b3kuSUQgPH19X2IuZnVzZScgYW5kICd7ez4gU2hhZGVydG95LklEIDx9fV9iLnBuZycgZmlsZXMgZnJvbQogICAgICAgICAgICB0aGUgJ1NoYWRlcmZ1c2VfYmV0YScgZm9sZGVyIGluIHlvdXIgJ0Z1c2VzJyBkaXJlY3RvcnkuCiAgICAgICAgPC9wPgogICAgICAgIDxwPgogICAgICAgICAgICBIb3dldmVyLCBpZiB5b3UgcmVzdGFydCBEYUZ1c2lvbiwgdGhlbiB0aGUgInt7PiBGdXNlLk5hbWUgPH19IiB0b29sIHNob3VsZCBiZSBnb25lIHdpdGggdGhlIHdpbmQgLi4uCiAgICAgICAgPC9wPgogICAgICAgIDxwIHN0eWxlPSJjb2xvcjojZmZmZmZmOyAiPkNoZWVycyE8L3A+CiAgICBdXQoKICAgIGxvY2FsIGVuZFNjcmVlbiA9IEVuZFNjcmVlbih0ZXh0KQogICAgZW5kU2NyZWVuOlNob3coKQoKZW5kCgpsb2NhbCBpbnN0YWxsV2luZG93ID0gSW5zdGFsbFdpbmRvdygpCmluc3RhbGxXaW5kb3c6U2hvdygpCnVpZGlzcGF0Y2hlcjpSdW5Mb29wKCkK")
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Get the code for an installer to install the fuse.
--

function installer_code(fuse)

    if not fuse:isValid() then util.set_error("can't create installer for invalid Fuse"); return nil end

    fuse.Thumbnail = fuse_thumbnail(fuse)   ; if not fuse.Thumbnail then return nil end
    fuse.Commit    = fuse_commit(fuse)      ; if not fuse.Commit    then return nil end
    fuse.MiniLogo  = fuse_minilogo(fuse)

    local fuse_code      = patch_fuse_source(fuse,fuse_source(fuse))
    local installer_code = patch_installer_source(fuse,installer_source(),fuse_code)

    fuse.Thumbnail = nil
    fuse.Commit = nil
    fuse.MiniLogo = nil

    return installer_code
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Get path to repository, if not already initialized.
--
-- @param repositorypath The path to the repository (optional).
-- @return Path to the reposiory.

function get_repositorypath(repositorypath)

  if not repositorypath then
    if user_config then
      repositorypath = user_config.pathToRepository
    else
      local user_config = require("Shaderfuse/~user_config")
      repositorypath = user_config.pathToRepository
    end
  end

  return repositorypath

end


-------------------------------------------------------------------------------------------------------------------------------------------
-- Generate and write the installer for a fuse.
--
-- @param fuse The fuse to create an installer for.
-- @param repositorypath The path to the repository (optional).

function create_installer(fuse,repositorypath)

  repositorypath = get_repositorypath(repositorypath)

  if not fuse:isValid() then
    util.set_error("can't create installer for invalid fuse ("..fuse:getErrorText()..")")
    return false
  end

  code = installer_code(fuse)

  if util.has_error() then return false end

  if (code or '') == '' then util.set_error("no code"); return false end

  local fpath = repositorypath..'build/Shaderfuse-Installers/'..fuse.Category
  bmd.createdir(fpath)
  -- local fpath=fuse.DirName

  local fname = fuse.Name ..'-Installer.lua'
  local f = io.open(fpath..'/'..fname,"wb")
  if not f then util.set_error("failed to write "..fname); return false end
  f:write(code)
  f:close()

  return true
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Generate all installers for all (valid) fuses.
--
-- @param repositorypath The path to the repository (optonal).

function create_installers(repositorypath)

  repositorypath = get_repositorypath(repositorypath)

  fuses.fetch(repositorypath..'/Shaders/','installer')
  -- fuses.fetch(repositorypath..'/docs/','installer')

  for i, fuse in ipairs(fuses.list) do
    util.clr_error()
    create_installer(fuse,repositorypath)
    if util.has_error() then
      print("installer for '".. fuse.Name .."' failed: ".. util.get_error())
    else
      print("installer for '".. fuse.Name .."' created")
    end
  end

end





-------------------------------------------------------------------------------------------------------------------------------------------
-- Get the fuse's code as packaged for the atom.
--

function atom_code(fuse)

  if not fuse:isValid() then util.set_error("can't create installer for invalid Fuse"); return nil end

  fuse.Thumbnail = fuse_thumbnail(fuse)   ; if not fuse.Thumbnail then return nil end
  fuse.Commit    = fuse_commit(fuse)      ; if not fuse.Commit    then return nil end
  fuse.MiniLogo  = fuse_minilogo(fuse)

  local fuse_code      = patch_fuse_source(fuse,fuse_source(fuse))

  if fuse_code then
    fuse_code=[[

  --
  --       _____        _   _       _   ______    _ _ _
  --      |  __ \      | \ | |     | | |  ____|  | (_) |
  --      | |  | | ___ |  \| | ___ | |_| |__   __| |_| |_
  --      | |  | |/ _ \| . ` |/ _ \| __|  __| / _` | | __|
  --      | |__| | (_) | |\  | (_) | |_| |___| (_| | | |_
  --      |_____/ \___/|_| \_|\___/ \__|______\__,_|_|\__|
  --
  --   ... this File is managed by some scripts and can be
  --   overwritten at any time and without further notice!
  --         pls. see https://github.com/nmbr73/Shaderfuse
  --                                           for details
  --

  ]]
    .."\n\n\n"..fuse_code
  end


  fuse.Thumbnail = nil
  fuse.Commit = nil
  fuse.MiniLogo = nil

  return fuse_code
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Generate and write the atom for a fuse.
--
-- @param fuse The fuse to create an atom fuse for.
-- @param targetpath Where to wrte the fuse.

function create_package_fuse(fuse,targetpath)

  if not fuse:isValid() then
    util.set_error("can't create atom for invalid fuse ("..fuse:getErrorText()..")")
    return false
  end

  local code = atom_code(fuse)

  if util.has_error() then return false end

  if (code or '') == '' then util.set_error("no code"); return false end




  -- local fpath = repositorypath..'Installers/'..fuse.Category
  -- bmd.createdir(fpath)

  local f = io.open(targetpath ..'/'.. fuse.Shadertoy.ID ..'.fuse',"wb")
  if not f then util.set_error("failed to write "..fuse.Shadertoy.ID ..'.fuse'); return false end
  f:write(code)
  f:close()

  local from = fuse.DirName..'/'..fuse.Name..'.png'
  local to = targetpath ..'/'.. fuse.Shadertoy.ID ..'.png'

  if not util.copy_file(from,to) then
    util.set_error("failed to copy".. from ..' to ' .. to);
    return false
  end

  return true
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Generate the Atom package containing all (valid) fuses.
--
-- @param repositorypath The path to the repository (optional).

function create_package_fuses(repositorypath)

  repositorypath = get_repositorypath(repositorypath)

  fuses.fetch(repositorypath..'/Shaders/','reactor')

  local image       = require("Shaderfuse/image")


  local YourCompanyName = 'JiPi'
  local YourPackageName = 'Shadertoys'
  local PackageIdentifier = 'com.JiPi.Shadertoys'
  local TargetFilepath = repositorypath .. 'Atom/'
  local YourPackageVersion = '1.1'
  local YourPackageDate = "2022,12,19"      -- os.date("%Y,%m,%d")  -- !!!!!!
  local YourPackageDateFuse = "Dec 2022"    -- os.date("%b %Y")     -- !!!!!!


  -- bmd.createdir(TargetFilepath..PackageIdentifier)
  -- bmd.createdir(TargetFilepath..PackageIdentifier..'/Fuses')
  -- bmd.createdir(TargetFilepath..PackageIdentifier..'/Fuses/Shaderfuse_wsl')

  local targetpath = TargetFilepath..PackageIdentifier..'/Fuses/Shaderfuse_wsl'
  bmd.createdir(targetpath)

  local OurPackageDescription=''
  local OurDeployments=''



  local currentCategory=''
  local descriptionIndent='        '

  for i, fuse in ipairs(fuses.list) do

    util.clr_error()

    create_package_fuse(fuse,targetpath)

    if not util.has_error() then

        if fuse.Category ~= currentCategory then

          if currentCategory~='' then
              OurPackageDescription=OurPackageDescription
              ..descriptionIndent..'  </ul>\n'
              ..descriptionIndent..'</p>\n'
          end

          currentCategory=fuse.Category

          OurPackageDescription=OurPackageDescription..
              descriptionIndent..'<p>\n'..
              descriptionIndent..'    '..currentCategory..' Shaders:\n'..
              descriptionIndent..'  <ul>\n'

        end

        OurPackageDescription=OurPackageDescription..descriptionIndent..'    <li><strong style="color:#c0a050; ">'..fuse.Name..'</strong></li>\n'
        OurDeployments=OurDeployments..'          "Fuses/Shaderfuse_wsl/'..fuse.Shadertoy.ID..'.fuse",\n'
    end
  end

  if currentCategory~='' then
    OurPackageDescription=OurPackageDescription
      ..descriptionIndent..'  </ul>\n'
      ..descriptionIndent..'</p>\n'
  end

  local handle = io.open(TargetFilepath..PackageIdentifier..'/'..PackageIdentifier..'.atom',"wb")

  if not handle then
    print("dang! failed to write atom package description!")
    return false
  end

  handle:write([[
    Atom {
      Name = "]]..YourPackageName..[[",
      Category = "Shaders",
      Author = "]]..YourCompanyName..[[",
      Version = ]]..YourPackageVersion..[[,
      Date = {]]..YourPackageDate..[[},

      Description = ]]
      )

  handle:write('[[\n        <center>\n')

  handle:write('          <br />')
  handle:write(image.logo_html())
  handle:write('<br /><br />\n')

  handle:write(
          '          The package <font color="white">'..
          YourPackageName..[[</font> adds some Fuses that utilize DCTL to implement various Shaders as found on <a href="https://www.shadertoy.com/">Shadertoy.com</a>.<br />
          See our repository on <a href="https://github.com/nmbr73/Shaderfuse">GitHub</a> for some insights and to maybe constribute to this project?!?<br />
          Find tons of example videos on what you can do with it on JiPi's <a href="https://www.youtube.com/c/JiPi_YT/videos">YouTube Channel</a>.<br />
          Please note that - unless stated otherwise - all these Fuses fall under Creative Commond 'CC BY-NC-SA 3.0 unported'.<br />
          For most shaders this regrettably means that in particular <font color="#ff6060">any commercial use is strictliy prohibited!</font>
          </center>
          ]])

  handle:write(OurPackageDescription)

  handle:write([[
          <p>
          See the following videos for some examples:
          <ul>
              <li><a href="https://youtu.be/GJz8Vgi8Qws">The Shader Cut</a> by <a href="https://nmbr73.github.io/Shaderfuse/Profiles/nmbr73.html" style="color:#a05050; ">nmbr73</a> and</li>
              <li><a href="https://youtu.be/8sUu5GcDako">Other Worlds</a>,</li>
              <li><a href="https://youtu.be/OYOar65omeM">Lego</a>,</li>
              <li><a href="https://youtu.be/WGWCrhPNmdg">Mahnah Mahnah</a>,</li>
              <li><a href="https://youtu.be/QE6--iYtikk">War of the Worlds</a>,</li>
              <li><a href="https://youtu.be/ktloT0pUaZg">HappyEastern</a>,</li>
              <li><a href="https://youtu.be/ntrp6BfVk0k">Shadertoy -Defilee</a>,</li>
              <li><a href="https://youtu.be/4R7ZVMyKLnY">Fire Water</a>,</li>
              <li><a href="https://youtu.be/oyndG0pLEQQ">Shadertoyparade</a> all by <a href="https://nmbr73.github.io/Shaderfuse/Profiles/JiPi.html" style="color:#a05050; ">JiPi</a></li>
          </ul>
          </p>]])

  handle:write(']]')

  handle:write([[,
      Deploy = {]]..'\n'.. OurDeployments ..[[
      },

      Dependencies = {},
  }]])

  handle:close()

  return true

end



local function update_fuse_markdown_file(fuse)

  local prolog = '# '.. fuse.Name ..'\n'

  if fuse:isValid() then
    -- prolog = prolog .. '[![Download Installer](https://img.shields.io/static/v1?label=Download&message='..fuse.Name..'-Installer.lua&color=blue)]('..fuse.Name..'-Installer.lua "Installer")'
    prolog = prolog .. '<a href="'..fuse.Name..'-Installer.lua" download><img alt="Download Installer" src="https://img.shields.io/static/v1?label=Download&message='..fuse.Name..'-Installer.lua&color=blue" /></a>\n'
  end

  prolog = prolog .. '\n'

  if fuse:hasShaderInfo() then
    prolog = prolog .. "This Fuse is based on the Shadertoy '_[".. fuse.Shadertoy.Name .."](https://www.shadertoy.com/view/"
      .. fuse.Shadertoy.ID ..")_' by [".. fuse.Shadertoy.Author .."](https://www.shadertoy.com/user/"
      .. fuse.Shadertoy.Author ..")."

      if (fuse.Author or '') ~= '' then
        prolog = prolog .. " Conversion to DCTL and encapsulation into a fuse done by [".. fuse.Author .."](../Profiles/".. fuse.Author ..".md)."
      end

  else
    prolog = prolog .. fuse.Name .. ".sfi file does not contain sufficiend data yet."

    if (fuse.Author or '') ~= '' then
      prolog = prolog .. " This fuse is under construction by [".. fuse.Author .."](../Profiles/".. fuse.Author ..".md)."
    end
  end

  prolog = prolog .. " See [".. fuse.Category .."](README.md) for more fuses in this category.\n\n"

  if fuse:hasThumbnail() then
    if fuse:hasShaderInfo() then
      prolog = prolog .. '[!['.. fuse.Name ..' Thumbnail]('..fuse.Name..'.png)](https://www.shadertoy.com/view/'.. fuse.Shadertoy.ID ..' "View on Shadertoy.com")\n\n'
    else
      prolog = prolog .. '!['.. fuse.Name ..'Thumbnail]('..fuse.Name..'.png)\n\n'
    end
  end

  local epilog = ''

  if not fuse:isCompatible() then
    epilog = epilog .. "## Compatibility\n\n" .. fuse:getCompatibilityHTML() .. '\n\n'
  end

  if fuse:hasErrors() then
    epilog = epilog .. "## Problems\n\n" .. fuse:getErrorsMarkdown() .. '\n\n'
  end

  local handle

  handle = io.open(fuse.DirName..'/'..fuse.Name..'.md', "rb")
  if not handle then util.set_error("failed to open '"..fuse.Name..".md' in '".. fuse.DirName "/'"); return false end
  local md = handle:read("*all")
  handle:close()


  local a, b = md:find("<!%-%- %+%+%+ DO NOT REMOVE THIS COMMENT %+%+%+ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE %+%+%+ IT WOULD BE A REALLY BAD IDEA %+%+%+ %-%->")
  local c, d = md:find("<!%-%- %+%+%+ DO NOT REMOVE THIS COMMENT %+%+%+ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE %+%+%+ TRUST ME: JUST DON'T DO IT %+%+%+ %-%->",b)

  if a == nil or c == nil then util.set_error("markers in ".. fuse.DirName ..'/'..fuse.Name ..'.md not found'); return false end
  -- if a == nil or c == nil then return false end

  local upd = prolog .. "\n\n" .. md:sub(a,d) .. "\n\n" .. epilog

  if md == upd then
    return true
  end

  -- print("'".. md:sub(a,d) .."'")

  handle = io.open(fuse.DirName..'/'..fuse.Name..'.md', "wb")
  if not handle then util.set_error("failed to open '"..fuse.Name..".md' in '".. fuse.DirName "/' for writing"); return false end
  handle:write(upd)
  handle:close()


  return true
end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Generate the markdown files.
--
-- @param repositorypath The path to the repository (optional).

function create_markdown_files(repositorypath)

  repositorypath = get_repositorypath(repositorypath)

  -- fuses.fetch(repositorypath..'/Shaders/','development')
  fuses.fetch(repositorypath..'/docs/','development')

  local overview = io.open(repositorypath..'docs/OVERVIEW.md',"w")
  local readme   = io.open(repositorypath..'docs/README.md',"w")

  if not(overview) or not(readme) then
    print("We have a Problem")
    return false -- os.exit(10)
  end

  local header=[[

  <!--                                                             -->
  <!--           THIS IS AN AUTOMATICALLY GENERATED FILE           -->
  <!--                                                             -->
  <!--                  D O   N O T   E D I T ! ! !                -->
  <!--                                                             -->
  <!--  ALL CHANGES WILL BE OVERWRITTEN WITHOUT ANY FURTHER NOTICE -->
  <!--                                                             -->


]]

  overview:write(header)
  readme:write(header)

  -- local links=''

  -- for i,cat in ipairs(fuses.categories) do
  --   links=links..' · ['..cat..']('..cat..'/README.md)'
  -- end


  -- overview:write("[README](README.md) · **OVERVIEW**"..links.."\n\n")
  -- readme:write("**README** · [OVERVIEW](OVERVIEW.md)"..links.."\n\n")

  overview:write('# Shaders\n\n')
  readme:write('# Shaders\n\n')

  local readme_cat=nil

  local currentCategory=''

  local boom=0
  local okay=0

  for i, fuse in ipairs(fuses.list) do

    util.clr_error()

    if fuse.Category ~= currentCategory then -- new category

      if currentCategory~='' then
        overview:write('\n\n')
        if readme_cat~=nil then
          readme_cat:close()
          readme_cat=nil
        end
      end

      currentCategory=fuse.Category

      overview:write("## "..fuse.Category.." Shaders\n\n")
      readme:write('\n\n**['..fuse.Category..' Shaders]('..fuse.Category..'/README.md)**\n')

      readme_cat   = io.open(repositorypath..'docs/'..fuse.Category..'/README.md',"w")
      readme_cat:write(header)

      -- local links='[README](../README.md) · [OVERVIEW](../OVERVIEW.md)'

      -- for i,cat in ipairs(fuses.categories) do
      --     if cat==currentCategory then
      --       links=links..' · **'..cat..'**'
      --     else
      --       links=links..' · ['..cat..'](../'..cat..'/README.md)'
      --     end
      -- end

      -- readme_cat:write(links.."\n\n")
      readme_cat:write("# "..fuse.Category.." Shaders\n\n")

      local description_cat = io.open(repositorypath..'Shaders/'..fuse.Category..'/DESCRIPTION.md',"r")
      local description = ''

      if description_cat then
        description = description_cat:read "*a"
        description_cat:close()
      end

      if description ~= nil and description ~= '' then
        readme_cat:write(description.."\n\n")
      end

    end -- new category



    if fuse:hasErrors() then
      boom=boom+1
    else
      okay=okay+1
    end

    if readme_cat==nil then
      print("Okay '"..fuse.Name.."' causing some trouble!")
      print("Category is '"..fuse.Category.."'")
    end


    overview:write(
        '\n'
      ..'!['..fuse.Category..'/'..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'_320x180.png)\\\n'
      ..'Fuse: ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) '..(not(fuse:hasErrors()) and ':four_leaf_clover:' or ':boom:')..'\\\n'
      ..'Category: ['..fuse.Category..']('..fuse.Category..'/README.md)\\\n'
      )



    update_fuse_markdown_file(fuse)






    if (not(fuse:hasErrors())) then
      overview:write(
          'Shadertoy: ['..fuse.Shadertoy.Name..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..')\\\n'
        ..'Author: ['..fuse.Shadertoy.Author..'](https://www.shadertoy.com/user/'..fuse.Shadertoy.Author..')\\\n'
        ..'Ported by: ['..fuse.Author..'](../Site/Profiles/'..fuse.Author..'.md)\n'
        )

      readme:write('- ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) (Shadertoy ID ['..fuse.Shadertoy.ID..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..')) ported by ['..fuse.Author..'](../Site/Profiles/'..fuse.Author..'.md)\n')
      readme_cat:write('## **['..fuse.Name..']('..fuse.Name..'.md)**\nbased on ['..fuse.Shadertoy.Name..'](https://www.shadertoy.com/view/'..fuse.Shadertoy.ID..') written by ['..fuse.Shadertoy.Author..'](https://www.shadertoy.com/user/'..fuse.Shadertoy.Author..')<br />and ported to DaFusion by ['..fuse.Author..'](../../Site/Profiles/'..fuse.Author..'.md)\n\n')


    else

      overview:write('**'..fuse:getErrorText()..'**\n')
      readme:write('- ['..fuse.Name..']('..fuse.Category..'/'..fuse.Name..'.md) :boom:\n')
      readme_cat:write('## **['..fuse.Name..']('..fuse.Name..'.md)** :boom:\n- *'..fuse:getErrorText()..'*\n\n')

    end

    if util.has_error() then
      print("problem with fuse '".. fuse.Name .."': ".. util.get_error())
    end

    overview:write('\n')

  end

  if currentCategory~='' then
    overview:write('\n')
  end

  if okay > 0 then
    overview:write(":four_leaf_clover: "..okay.."\n\n")
  end

  if boom > 0 then
    overview:write(":boom: "..boom.."\n\n")
  end


  if readme_cat~=nil then readme_cat:close() end

  overview:close()
  readme:close()


end



-------------------------------------------------------------------------------------------------------------------------------------------
-- Generate the CSV file.
--
-- @param repositorypath The path to the repository (optional).

function create_csv(repositorypath)

  repositorypath = get_repositorypath(repositorypath)

  fuses.fetch(repositorypath..'/Shaders/','development')

  local csv      = io.open(repositorypath..'Shaders.csv',"w")

  if not(csv) then
    print("We have a Problem")
    return false -- os.exit(10)
  end

  csv:write("Shadertoy ID,Shader Autor,Shader Name,Category,Fuse Name,Ported by,Issue\n")

  for i, fuse in ipairs(fuses.list) do

    csv:write(
        '"'.. fuse.Shadertoy.ID ..'",' ..
        '"'.. fuse.Shadertoy.Author ..'",' ..
        '"'.. fuse.Shadertoy.Name ..'",' ..
        '"'.. fuse.Category ..'",' ..
        '"'.. fuse.Name ..'",' ..
        '"'.. fuse.Author ..'",' ..
        '"'.. (not(fuse:hasErrors()) and '' or fuse:getErrorText()) ..'"\n'
        )

  end

  csv:close()

  return true
end



