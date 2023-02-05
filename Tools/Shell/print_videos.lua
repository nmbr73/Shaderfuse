#!/usr/bin/env lua

local videos = {
  { Video = "oyndG0pLEQQ", Channel = "JiPi",   Title = "WebGL to DCTL: Shadertoyparade", },
  { Video = "GJz8Vgi8Qws", Channel = "nmbr73", Title = "The Shader Cut", },
  { Video = "ntrp6BfVk0k", Channel = "JiPi",   Title = "WebGL to DCTL: Shadertoy -Defilee", },
  { Video = "QE6--iYtikk", Channel = "JiPi",   Title = "WebGL to DCTL: War of the Worlds", },
  { Video = "WGWCrhPNmdg", Channel = "JiPi",   Title = "WebGL to DCTL: Mahnah Mahnah", },
  { Video = "OYOar65omeM", Channel = "JiPi",   Title = "WebGL to DCTL: Lego", },
  { Video = "8sUu5GcDako", Channel = "JiPi",   Title = "WebGL to DCTL: Other Worlds", },
  { Video = "OKpJbFisE4c", Channel = "JiPi",   Title = "FiftyToysOfShaders", },
  { Video = "wKhv1nPb2lk", Channel = "JiPi",   Title = "WebGL to DCTL: Reaction Diffusion", },
  { Video = "dFqDDr7S_K0", Channel = "JiPi",   Title = "WebGL to DCTL: Fire & Water Volume 2", },
  { Video = "f14cOuMq-vk", Channel = "JiPi",   Title = "WebGL to DCTL: Pinballgimmick", },
  { Video = "tDWsdnl7SdE", Channel = "JiPi",   Title = "WebGL to DCTL: ABookOfShadertoys", },
  { Video = "ZyZ2y_07wXs", Channel = "JiPi",   Title = "How To Catch A Shaderfuse (deutsch)", },
  { Video = "ExNG8n559NY", Channel = "JiPi",   Title = "How To Catch A Shaderfuse", },
  { Video = "3vrS5hUsU60", Channel = "JiPi",   Title = "WebGL to DCTL: Hexatrance", },
  { Video = "UVl4vYk1D-o", Channel = "JiPi",   Title = "WebGL to DCTL: Holly Jolly Christmas", },
  { Video = "QTft66_s8qY", Channel = "JiPi",   Title = "WebGL to DCTL: Fetch N Fuse", },
  { Video = "3ikzubTYlm0", Channel = "JiPi",   Title = "WebGL to DCTL: Peace", },
  { Video = "EIIfA28pvZQ", Channel = "JiPi",   Title = "WebGL to DCTL: Relaxtion", },
  { Video = "68haN89yG7A", Channel = "JiPi",   Title = "WebGL to DCTL: FallingSand !Native Rendering !", },
  { Video = "V5BVk5RO3yk", Channel = "JiPi",   Title = "WebGL to DCTL: Dalmatiner Edition", },
  { Video = "83ZjzUh1NB0", Channel = "JiPi",   Title = "WebGL to DCTL: Podracing", },
  { Video = "VwIa6QokOFk", Channel = "JiPi",   Title = "In Memoriam", },
  { Video = "ArkJzr2Aej0", Channel = "JiPi",   Title = "WebGL to DCTL: Favorite Shaders", },
  { Video = "JtOvp7-Cmzg", Channel = "JiPi",   Title = "WebGL to DCTL: Wedding", },
}

local creators = {
  JiPi = { Link = "https://www.youtube.com/@JiPi_YT", },
  nmbr73 = { Link = "https://www.youtube.com/@nmbr73", },
}

local width = 120
local height = 90

print('# Videos\n\n')

print([[Find here a list of example videos created using the Shaderfuses. Additionally we maintain a [Shaderfuse Playlist](https://www.youtube.com/playlist?list=PLqbIsaWc6bt1AuwEHF116QcFsNPKnLYHD) where you can find all these videos (and more). Let us know if you've created some content with these fuses yourself and we'll be glad to add the link to your YouTube video here.]])

print('\n\n<table cellspacing="10" style="border-width:0px; ">')
for i = 1,#videos do
  local id = videos[i].Video
  local title = videos[i].Title
  local href = 'http://www.youtube.com/watch?feature=player_embedded&v='..id
  local creator = videos[i].Channel

  title = title:gsub('^WebGL to DCTL: ','')
  title = title:gsub('&','&amp;')

  if creators[creator] ~= nil then
    creator = '<a href="'..creators[creator].Link..'">'..creator..'</a>'
  end

  print('<tr>')
  print('<td style="border-width:0px; "><a href="'..href..'" target="_blank"><img src="http://img.youtube.com/vi/'..id..'/0.jpg" alt="Link to Video" width="'..width..'" height="'..height..'" border="0" /</a></td>')
  print('<td style="border-width:0px; "><strong style="font-size:x-large; ">'..title..'</strong><br /><a href="'..href..'" target="_blank"><img src="https://img.shields.io/youtube/views/'..id..'?style=social" /></a><br />by '..creator..'<br />')
  print('</td>')
end
print('</table>')



