--- A Fuse class.
--
-- Class to help to work with a fuse file.
--
-- Dependencies: `bmd.fileexists`, `Shadertoys/ShaderFuse`
-- @classmod Fuse


-- Für die Versionierung (später): Ein git log -n 1 --pretty="format:%h %cs" -- <FILE>
-- zum Beispile liefert '97f7ee0 2022-12-19', was ja schon mal ganz brauchbar wäre.



local Fuse = {}



------------------------------------------------------------------------------
-- Create an instance.
--

function Fuse:new(filepath,phase,read_info)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o:init(filepath,phase,read_info)

  return o
end



------------------------------------------------------------------------------
-- Clear an instance's data.
--

function Fuse:clear()
  self.Name         = '' -- Fuse (file)name (without suffix)
  self.DirName      = '' -- Fuse path (incl. Category, without trailing slash)
  self.FilePath     = '' -- Fuse filepath (full path, incl. category and suffix)
  self.Category     = ''
  self.InfoURL      = 'https://nmbr73.github.io/Shadertoys/'
  self.Description  = ''
  self.Author       = ''
  self.AuthorLogo   = nil -- { Width, Height, Data }
  -- ...

  self.errors = {}

  self.Shadertoy = {}
  self.Compatibility = {}
  self.CompatibilityIssues = {}
  self.FuRegister = {}

  self._hasThumbnail = false
end



------------------------------------------------------------------------------
-- Check if valid thumbnail file existst.
--

function Fuse:hasThumbnail()

  assert(self ~= nil, "call as INSTANCE:hasThumbnail()")

  if not self._hasThumbnail then
    return false
  end

  return true
end



------------------------------------------------------------------------------
-- Check if minimum Shadertoy info is available.
--

function Fuse:hasShaderInfo()

  assert(self ~= nil, "call as INSTANCE:hasShaderInfo()")

  if not self.Shadertoy then
    return false
  end

  if not (self.Shadertoy.ID and self.Shadertoy.Name and self.Shadertoy.Author) then
    return false
  end

  if self.Shadertoy.ID == '' or self.Shadertoy.Name == '' or self.Shadertoy.Author == '' then
    return false
  end

  return true

end



------------------------------------------------------------------------------
-- Keys for the compatibility checks.
--

function Fuse:compatibilityKeys()
  return {'Windows_CUDA','Windows_OpenCL','macOS_Metal','macOS_OpenCL'}
end


function Fuse:isCompatible()

  if self.Compatibility == nil then
    return false
  end

  return self.Compatibility.Windows_CUDA and self.Compatibility.Windows_OpenCL
    and self.Compatibility.macOS_Metal and self.Compatibility.macOS_OpenCL

end


------------------------------------------------------------------------------
-- Initialize the object.
--

function Fuse:init(filepath, phase, read_info)

  read_info = read_info or false
  self.errors = {}
  self.Compatibility = {}
  self.Shadertoy = {}

  assert(phase ~= nil, "phase must be specified")
  assert(phase == 'development' or phase == 'installer' or phase == 'reactor', "bad phase")
  assert(filepath ~= nil, "filepath must be specified")

  self.Phase = phase
  self.FilePath = filepath

  -- folder is 'Shaderfuse_dev' if called from within Fusion (on the repository link);
  -- it is 'Shaders' (i.e. called from a shell script) otherwise.

  self.DirName, self.Category, self.Name =
    filepath:match('^(.+[/\\]Shaders/)([^/]+)/([^%.]+)%.fuse$')

  if ((self.DirName or '') == '') and (phase == 'development') then
    self.DirName, self.Category, self.Name =
      filepath:match('^(.+[/\\]Shaderfuse_dev/)([^/]+)/([^%.]+)%.fuse$')
  end

  if (self.DirName or '') == '' or (self.Category or '') == '' or (self.Name or '') == '' then
    self:addError("filepath '"..self.FilePath.."' does not match the expected schema")
    return false
  end

  self.DirName = self.DirName .. self.Category

  -- if not bmd.fileexists(self.DirName..'/'..self.Name..'.md') then
  --   self:addError("markdown file does not exist")
  -- end

  if read_info then
    return self:readInfo()
  end

  return true
end






function Fuse:readInfo()

  assert(self ~= nil, "call as INSTANCE:readInfo()")
  assert(self.DirName ~= '' and self.Name ~= '', "call only if init ran without errors")

  if not bmd.fileexists(self.DirName..'/'..self.Name..'.sfi') then
    self:addError("shaderfuse info (.sfi) file does not exist")
    return false
  end

  dofile(self.DirName .. '/' .. self.Name .. '.sfi')

  if info == nil then
    self:addError("failed to read shaderfuse sfi file");
    return false;
  end


  if info.Shadertoy == nil then

    self:addError("no Shadertoy information")

    self.Shadertoy = {
      ID = '',
      Name = '',
      Author = '',
      License = 'CC BY-NC-SA 3.0',
      InfoURL = 'https://www.shadertoy.com/',
    }

  else

    -- ----------
    -- Mandatory: Shadertoy.ID, .Name, .Author

    if (info.Shadertoy.ID or '') == '' then info.Shadertoy.ID = ''; self:addError("no Shadertoy.ID in sfi file") end
    if (info.Shadertoy.Name or '') == '' then info.Shadertoy.Name = ''; self:addError("no Shadertoy.Name in sfi file") end
    if (info.Shadertoy.Author or '') == '' then info.Shadertoy.Author = ''; self:addError("no Shadertoy.Author in sfi file") end

    -- ----------
    -- Optional (kind of): Shadertoy.License

    if (info.Shadertoy.License or '') == '' then
      info.Shadertoy.License = info.Shadertoy.Author ~= '' and "© "..info.Shadertoy.Author.." (CC BY-NC-SA 3.0)" or "CC BY-NC-SA 3.0"
    end

    -- ----------
    -- Auto: Shadertoy.InfoURL

    info.Shadertoy.InfoURL = 'https://www.shadertoy.com/view/'.. info.Shadertoy.ID

    self.Shadertoy = info.Shadertoy

  end

  if info.Fuse == nil then

    self:addError("no Fuse information")

    self.Author = ''
    -- ...

  else

    -- ----------
    -- Auto: Fuse.InfoURL
    --
    --    TODO: Bei Gelegehnheit die GitHub Pages so umstrukturieren, daß die Informationen unter
    --    der Shadertoy-ID abgelegt werden. Dabei ggf. eine Variant für Dev und eine für Reactor
    --    generieren.

    -- if info.Fuse.InfoURL ~= nil then self:addError("Fuse.InfoURL must not be set in sfi file") end

    if self.Category ~= '' and self.Name ~= '' then
      self.InfoURL = 'https://nmbr73.github.io/Shadertoys/Shaders/'.. self.Category ..'/'.. self.Name ..'.html'
    else
      self.InfoURL = 'https://nmbr73.github.io/Shadertoys/'
    end

    -- ----------
    -- Mandatory: Fuse.Author

    if (info.Fuse.Author or '') == '' then
      info.Fuse.Author = ''
      self:addError("no Fuse.Author in sfi file")
    end

    self.Author = info.Fuse.Author

    -- ----------
    -- Optional: Fuse.Description

    self.Description = info.Fuse.Description or ''

    -- ----------
    -- Optional: Fuse.AuthorLogo

    self.AuthorLogo = nil

    if info.Fuse.AuthorLogo then

      if type(info.Fuse.AuthorLogo) == "table" then

        local ok = true

        if (info.Fuse.AuthorLogo.Data or '') == '' then ok = false; self:addError("no Fuse.AuthorLogo.Data in sfi file") end
        if (info.Fuse.AuthorLogo.Width or '') == '' then ok = false; self:addError("no Fuse.AuthorLogo.Width in sfi file") end
        if (info.Fuse.AuthorLogo.Height or '') == '' then ok = false; self:addError("no Fuse.AuthorLogo.Height in sfi file") end

        if ok then
          self.AuthorLogo = {
            Width = info.Fuse.AuthorLogo.Width,
            Height = info.Fuse.AuthorLogo.Height,
            Data = info.Fuse.AuthorLogo.Data,
          }
        end

      else

        if info.Fuse.AuthorLogo == "supress" then
          self.AuthorLogo = nil
        else
          self:addError("unknown Fuse.AuthorLogo in sfi file")
        end

      end

    else

      local author_logo = {
        JiPi = { Width = 259, Height = 60, Data = "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", },
        nmbr73 = { Width = 212, Height = 41, Data = "iVBORw0KGgoAAAANSUhEUgAAANQAAAApCAYAAABN0gffAAABg2lDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TRZFKh3YQEclQnSyIijhqFYpQIdQKrTqYXPoFTRqSFBdHwbXg4Mdi1cHFWVcHV0EQ/ABxc3NSdJES/5cUWsR4cNyPd/ced+8AoVFhmtU1Dmi6baaTCTGbWxV7XiEgjAhiGJaZZcxJUgq+4+seAb7exXmW/7k/R7+atxgQEIlnmWHaxBvE05u2wXmfOMpKskp8Tjxm0gWJH7muePzGueiywDOjZiY9TxwlFosdrHQwK5ka8RRxTNV0yheyHquctzhrlRpr3ZO/MJTXV5a5TnMISSxiCRJEKKihjApsxGnVSbGQpv2Ej3/Q9UvkUshVBiPHAqrQILt+8D/43a1VmJzwkkIJoPvFcT5GgJ5doFl3nO9jx2meAMFn4Epv+6sNYOaT9Hpbix0B4W3g4rqtKXvA5Q4w8GTIpuxKQZpCoQC8n9E35YDILdC35vXW2sfpA5ChrlI3wMEhMFqk7HWfd/d29vbvmVZ/P2tycqR3fEbRAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH5QIPFAcPbC/jXQAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAA9tSURBVHja7Z15eFRVmsZ/d6lKbVlYQiAJmISQoCAIaABtFWVaHsOm3bboINJuOLajz0zPMz099rRiL04r0qLS6jgt2i4tERC3RLttlxmNyAAqi6wxBkKoEBKyp9Z77/xRRaXurZsNCES47z+hTp06yz3nPd/3veeci0AfsKBs9mRgiyH5i5Li0imcAiwom70FmGxInlJSXPoFFiwMAIjWI7BgwSKUBQsWoSxYONMhn4QyhGhsFY9gSXHpDuvxWjjbIJwEoeCkCxWnW/ywYMFy+SxYsAhlwYJFKAsWLHSBkyFKBAHjxuoOk7hoBHCnIdlbUlz6X9YwWDhT0CdRoouTCs8CSwxp/wNc3ot8x4hoLHMh8IpJXmM+SopLBWsYLZxJFmpAo2jq9LuPrQfA9DO1z7IsMzI7C1nu7J6qaVRWfoumaaelTcOHD+fR5csRRRFORhuEbtZOTUMIhyJ/NdCESH5NlkHoMrI5CjjiPvuBy/PzcnYAVFRWtRt/kJ+X4z7274rKqi1nHaGAPwHZwCWACmichO2CgYaCMWN47LHlpKamdvriwSBz5s6jpaX19LpBAT+eD95D9AeOu4xQdjYdU7+XQExBUbBVV+H4YhO2Lf+LeLACwe9Dc7pRR44mfMEl+M+/gGDeGDTZZix2sOGzC7AbPneHyWcjoUYCClANNABDo/0+s0glgCAICHGruCgODM1JCIdIeudlpMrjPMOsaQg3/muEUHEQfR0kv1GC4+XfgqLq62wGsXYv8qZ3cQgawfn30HL9zSiDh556l29B2Ww7MN5EfHCaZDcbNbuZBxCNreKxBZhrkvfcPsR1k02EDm/c5yuAKmAPsB74ITDM8va/YzB4jEIwSMqLz5C0/sme10ZNwL7+CdJqD9L00/tRUtJOeQw1HpOTCoDPJO/TJcWldxgm+dJovBKPVBOh4mPgz8ADhnTFTGxYUDbbzBE3tvNBYGnc50uBVqAccCcOjYXTwg+nA0TB1NQKwTCEgp1JziEEx03QuXvOrzaR9NYqPZnsLsLnXw52B9L2TxDajnR+L4jIn72Oq+gyWq+e3308ZokS3WINUBeNo84BpPgvPR4PQ4cM0Y1LR4ePuro6XC4X6elDEQQBJazgra0lFArp3KoE02y3M3x4hs7dCocVDh48iM1mY3hGBpIsoWnQ1tbG0aNHdaKBpmmkpCSTljYISRLRNI0jR+ppb2/vtt7uIEkyw4dnYLPJoEFDQwMtra3dlhff92MIBAJ4vbW6fOnp6bjdkVDj8OE6fD5fL2adh6aVpSgeT2Jbm5tI/d19iJUbowkyHXf8Ox0Xxq3PqoKz7HVQOjqf27BCWn72EIHRBSAIyA31pDz7OPLG9XG+lEjSB2/QfuUsVIcT4HogPrAKod/yWdhDT6acjYR6H5gDXBi1Vjp7f838edx66y26ibNz5y5279nN3DlzsNlssYkeCASoqKhg1arn+fKrreZR6qQLuP/+X+J0dnrHLS0tPLfqeW6/7TY8HnesLlXVaGho4P333+f5F17g8ssu44YbbyA3JwdRFBEEAQ1QwmFqamp44403efOtt/uk2k2fPo0lS5YwKC0tVq+iKHi9XkpLy1izdh2KoiT87u9mXsm9996DJHWuPwcOHOCGv7+JvJwc7rrrH5h4wUTcLlcsdnvyyZWse319L4IqESUlFSU5RZ8cCpK89mXEyg2xSCI461barpoHYmc7pKP1SFX74sydSnDmPPzjJ3UyI2sU7dcuIHVTKaid1k78ZhNE+5ufl7Omu2bm5+X8uYfvvzgbCRWIqjE/AgZFLZQQb1Fc0UlxDMOGpXPuuWNxu926gtxuN0VFRRQWFvLkyj/w9tvvJC6+sozL5dIRCmDRTQvJyEgM3TweNz/+8WLGjTuPcePGkZKSYtqJlJQURo8ezdixhTz8yKO9IpUgCNy0cCHZWVkJ3yUnJ5Obm0tBQQG/+e1DqKo+qLfZbLhcLh2hnE4nI7OzWLHi94wcOTLBwtnstq4bk+RES86OMsKe6HJpGu5PPyLp9T/EyKRlnEfrdQvRbPpyNYeTtrt/jhgIIjY3IdYdJDBuQnRY46y9zaQeR0q/uXvdEaqr0w9DgN3G2MhEGJAArzEuIrK5G4/90TY8axA5agxlBrvpg7GdxnodROTywVEZtMenmZmZSSAQYMOGDQSCQc4dO5aMjIzODqemcsftt7H1q60cqK7u8SE7HA7S09PZum0bDfUNnJNzDnm5ubEJKcsy06dPj1mPr3fupP5IPaNGjSIvLzfmPtrtdq6++mq2bdtO2bvv9cLVkxg1ahS7du3C6/WSmZlJQUFBrDybzcZVV32fXbt2sWbtul5NmHvv+UdGjRrVp0mmOt003vcIQswSCqguvSJtP1CJ6+lfgRIdakHCd+MSwiOyE8vzpNBx0cUxIqJpUZJ0kkn0+3Bt+AQUvVSvjPteZG+K2D6TURqfcszyRPeZJnf1vSmhFpTNHk9kr8ZInh0GpW+8SeFEhQajqPAsMMKQ1gxcaUi7sIsyb++BNPH1GE9fTIye6DimDknBo2G5ZmWLjV5K5YqisOLxJ3jnnVI0TSM3N4dljzxCdnZWnBUbxpw5s3nq6Wd6NalKS8v4/WOPoSgqbpeLZcseZsqUKYZFWuPtt99h2aPLCYfDeDwe/vOh31BUVKQj5zXXzOfd9/7SKyv1ySef8qtf/5pgMITdbufBBx/gihkzYmS22WwUzy5mdclrOmvUFUEnTZrU92VbFFHSR3Qrq7vL1iO0HIoNkZo1jo7pl/ZsTQQhlkdqOorsPYh8pA7Hh2XIG98ytEPCN2s+mj0pFir2h4WydzGp6SZ9IEPStVsAySkeiRNfeyRV1f79vPvuezE36JtvKvnwow+5edEinTuVPyY/Euf0MLHb29v543OrUKJ7Je0dHaxZs5aJEyfqTjY0NTWxdt06wuEwEBEtXl29WkcogEGDBpGWlkpjY1O39YbDYZ5b9TzBYChi5oNBSla/xrSpU3HFWYjMESPweDw9CgppaWnIsozf7ycQCCS4l36//7gGzF6xB/tbK+ncgRHw/2Bx3+RtQcD1yfu4nvg3kITEYZbt+G75Jb7J0/p18p0NMRSaShJQH3VZ5ejIdUmscCiE3++PrdiCINBQ35CQz+lwIEki4bDSff1RpU6WOy1AzaFDCUQMBoPUG+ppbmpG0zRdvOJyuXC73D0SCqChoV7vD9d6E0QISZIYPHgwNTU13Zbl8Xj4+uudvPjSS+zbuw/FEHc1Njb2eWyEYAD3G6tB61RFNXc6vqmXHEesI0RHVf87zZVG+0+X0THt8pi7ZxHqBCDItAFPATOATKDQKJ+fAloPjMXlBJrR2NjI7x5+mL1795209ti/3Yft41d0JAhdcS1K2uCTN/6hII5PP0ZNTsV3/iSdYni6CVUBhE1cLKNQ0WAiQKgm5XlN4iMniRvIXb2fQumVCy8LbcCXQCWRvYdCLPQZra2t7Ny5S+emnhBUFefmjXqLoqkELroYTep7HUpqKqEZCxAaapG++RLB3xZlaAfyx6+QsvE9pLvup21mMUS8D+M+kjc/LycmauXn5Uw5HkJpJoSoAe4j8QjRtcB/GNIuBcYa0oZgflXDmG8s5tcyjGLD5Ghaj9c3osemLos9ZL+aSeSo0XAip4ktHLd101AU5aQRSmxvxf6X1/R1OFwECscfl+n1XTwT37QZoKpIjUdJXr8a+1tPdXoHvgbcK39BcHQBwdGFdKfWnYiFEkwmeofZW4sWlM2eN9AHvaS4NLigbHasP5Ij5pvfFrWmbosaAwOOPTsR6r/VW5kJM1Edjt77r8d8WFGMxkcRsodHZNFy020M2rkZqWJjXKDahuvTDwnm5lsx1AniIyAXuA7r6v+AUIrs2zaDqo8gwhOmoiV1TyjXl5uQmpoQ62sR6r2gKrQsvhvVo98UVzzJhItm6AkFSLu/RFAUKiqrlpu4fU/m5+WsswjVM1YAP7dm8gARilQNefvmhJgqPGRwj+pe0gel2P/2Yic3h+QgXrc4gVBoQCDRyxeCMcn/RhL3S/cAp4xQHV0IEEZftJZevGfiFCObyOZyXTSeks/GiZyUZDf1nEKh0Clth9jUgFh7KIEAakpqj78NF47H/rfOLUXhSCVJe3cRzsjUT+6GI9jL/5ooXoweh9ZPd8Xk6EQ3KnJdqWcuk3irpKS49IcmeR84wbbdaRLDeXv521JgdHSQRE3DNni+c8LRN32biZwuPistlaZpTJs2FYchRmlvb6O29jCi2L93LqW2FqToXpXtmz0Ibd4EQokdPuzV+yOTMG1QwgFagMCESTiTsxBaD8XiJ9dLz6C63JHYSBSQ64/gefUFhNpdCa5m4MJLQOqf9VSOBvFLTL77yQCcE2YkXWqSNiJG/OjJFClZ9AGfRX1m9Wwh0dChQ3G53CQl2SkquoibFy2KnaA/RrLt27f353nRTuu4cxvJ/3RTRDuWAJvBSsgingdvjyznArQ9/CrtRdMTyglm5xCcdT1Ja1d0WrwDW0i57wbU4QVgdyLWbAU18cREePoP8J8/qd/6OCDcngVlszMBX0lxaWN/1aEFNBcROb0VaCMyrGf0G5NkWeaZp5+KrCuCgNPp1JEJoLa2lmf/+4/Hfdeqb4GTEPFx5G7cLZsY8SHizuglmjqJ1usWIdVUI2+IC3cEEfFwxTGKGWcAyvlX0fyTn6E6Y8euXjURJf76nSdUSXHpof6uQw1pLmB71Hp1kPiCjjMv8BcE3UtbjO7f7t27WfH4E1RXH/zO9U1JG0TTP/8Cz5hCkl5/DqG9zvwYiCCCexj+H91J26y5uhMY+Xk5/3K6LZTZyQbviTYieuLdGC3biNygPCmwp8tVRN4tcW58vyu//Zby8nJd3qqqKgRD0Lr/wAHKy8t15+/27tuHquoH8XBdHZ9t2ECS3R4Xo3QkvDClubmZ8vJy3SZpY2MjAYMq1djYlNC+5uZm2tr1b7hqamzi888/T7jDZYZDh7xs3bqV/9u0mZaWFtM81dXVlJeX69p9+PBhpBOIPUJZ59Bx/wu99gtCWSO7J1VKGs033IL8/bkkVexBrtiNtH8PQlsTatpQ1Mw8QgXnERwzlvCgIXAKXlojRCf0UhOrsbQPZPhTF4qecct7cRcbxmb3TszwYG/a2QVBd5QUlwaxYKE/3ey+kKerxZ/eX/+wn6BruLSX+az/m8rCaYF1YsCCBYtQFiwMYJdvAMDMRTO7xmHBwhlPqB0kavnBLmKmHV3EPIutobBwJuD/AbGgUv9INd91AAAAAElFTkSuQmCC", },
      }

      self.AuthorLogo = author_logo[info.Fuse.Author]

    end

    -- ----------
    -- Optional: Fuse.AuthorURL

    self.AuthorURL = info.Fuse.AuthorURL

    if not self.AuthorURL then

      local author_url = {
        JiPi = "https://www.youtube.com/c/JiPi_YT",
        nmbr73 = "https://www.youtube.com/c/nmbr73",
      }

      self.AuthorURL = author_url[info.Fuse.Author]
    end


    -- ----------
    -- Optional: Fuse.Version

    self.Version = ''

    if info.Fuse.Version then
      if not info.Fuse.Version:match("^v([0-9]+)%.([0-9]+)%.([0-9]+)$") then
        self:addError("Fuse.Version must be v<MAJOR>.<MINOR>.<PATCH>")
      else
        if self.Phase == 'development' then
          self.Version = info.Fuse.Version .. '-alpha'
        elseif self.Phase == 'installer' then
          self.Version = info.Fuse.Version .. '-beta'
        elseif self.Phase == 'reactor' then
          self.Version = info.Fuse.Version
        else
          assert(false, "unknown phase '"..self.Phase.."'")
        end
      end
    end


    -- ----------
    -- Optional: Fuse.Date
    --
    --    TODO Auto: Fuse.Modified

    self.Date = ''

    if info.Fuse.Date then
      if not info.Fuse.Date:match("^([0-9][0-9][0-9][0-9])%-([0-9][0-9])%-([0-9][0-9])$") then
        self:addError("Fuse.Date must be YYYY-MM-DD")
      else
        self.Date = info.Fuse.Date
      end
    end
  end


  -- ----------
  -- Auto: Fuse.hasThumbnail

  -- if info.Fuse.hasThumbnail ~= nil then self:addError("Fuse.hasThumbnail must not be set in sfi file") end

  self._hasThumbnail = false

  local thumb = io.open(self.DirName .. '/' .. self.Name .. '.png', "rb")

  if not thumb then
    self:addError("Thumbnail file does not exist")
  else
    local bytes = thumb:read(24)
    thumb:close()

    local signature = ''
    for i = 1, 8 do
      signature  = signature .. string.format( "%02x",string.byte( bytes, i ))
    end
    signature = signature .. 'XXXXXXXX'
    for i = 13, 24 do
      signature  = signature .. string.format( "%02x",string.byte( bytes, i ))
    end

    if signature ~= "89504e470d0a1a0aXXXXXXXX4948445200000140000000b4" then
      self:addError("Thumbnail seems to be not a 320x180 pixel PNG")
    else
      self._hasThumbnail = true
    end
  end


  -- ----------
  -- Optional (kind of): Compatibility
  -- Auto: Compatibility_issues


  if not info.Compatibility then
    self.CompatbilityIssues = { Windows_CUDA = 'not checked', Windows_OpenCL = 'not checked', macOS_Metal = 'not checked', macOS_OpenCL = 'not checked', }
    self.Compatibility = {}
    self:addError('Windows_CUDA compatibility not checked')
    self:addError('Windows_OpenCL compatibility not checked')
    self:addError('macOS_Metal compatibility not checked')
    self:addError('macOS_OpenCL compatibility not checked')

  elseif info.Compatibility == 15 then
    self.Compatibility = {  Windows_CUDA = true, Windows_OpenCL = true, macOS_Metal = true, macOS_OpenCL = true, }
    self.CompatbilityIssues = {  macOS_Metal = '', macOS_OpenCL = '', Windows_CUDA = '', Windows_OpenCL = '', }
  else


    for k , _ in pairs(info.Compatibility) do
      if k ~= 'macOS_Metal' and k ~= 'macOS_OpenCL' and k ~= 'Windows_CUDA' and k ~= 'Windows_OpenCL' then
        self:addError("unknown compatibility key '"..k.."'")
      end
    end

    self.Compatibility = {}
    self.CompatbilityIssues = {}

    for _ , k in pairs({'macOS_Metal','macOS_OpenCL','Windows_CUDA','Windows_OpenCL'}) do

      local value = info.Compatibility[k]
      local issue = ''

      if value == nil then
        issue = 'not checked'
        self:addError(k ..' compatibility not checked')
      elseif value == true then
        issue = ''
      elseif value == false then
        issue = 'does not work; no more details given'
        self:addError('does not work for '.. k ..'; no more details given')
      else
        issue = '' .. value
        value = false
        self:addError(k ..' compatibility: '.. issue)
      end

      self.Compatibility[k] = value
      self.CompatbilityIssues[k] = issue

    end
  end


  -- ----------
  -- Auto: FuRegister

  -- Depends on many of the previous entries!

  -- ShaderFuse.assert(info.Fuse.FuRegister == nil, "Fuse.FuRegister must not be set explicitely")

  local regs_name
  local regs_category
  local regs_opiconstring

  if self.Phase == 'development' then
    regs_name         = '_DEV'
    regs_category     = 'Shaderfuse (dev)'
    regs_opiconstring = 'sf-a.'
  elseif self.Phase == 'installer' then
    regs_name         = '_BETA'
    regs_category = 'Shaderfuse (beta)'
    regs_opiconstring = 'sf-b.'
  elseif self.Phase == 'reactor' then
    regs_name = ''
    regs_category = 'Shaderfuse'
    regs_opiconstring = 'sf.'
  else
    assert(false, "unknown phase '"..self.Phase.."'")
  end


  self.FuRegister = {}
  self.FuRegister.Name = "Shaderfuse_" .. info.Shadertoy.ID .. "_" .. self.Phase
  self.FuRegister.Attributes = {
      REGS_Name = self.Name .. regs_name,
      REGS_Category = regs_category .. "\\" .. self.Category,
      REGS_OpIconString = regs_opiconstring .. self.Shadertoy.ID,
      REGS_Company = self.Author,
      REGS_URL = (self.AuthorURL == nil or self.AuthorURL == '') and "https://nmbr73.github.io/Shadertoys/" or self.AuthorURL,
      REGS_OpDescription =
          "Shadertoy '".. self.Shadertoy.Name .."' (ID: ".. self.Shadertoy.ID ..") created by "
          .. self.Shadertoy.Author .." and ported by ".. self.Author .. ". ".. self.Shadertoy.License .. "."
          .. (self.Description ~= '' and " ".. self.Description .." " or " ")
          .. "This port is by no means meant to take advantage of anyone or to do anyone wrong: "
          .. "Contact us on Discord (https://discord.gg/75FUn4N4pv) and/or GitHub (https://github.com/nmbr73/Shadertoys) "
          .. "if you see your rights abused or your intellectual property violated by this work.",
      REG_Fuse_NoEdit     = ( self.Phase ~= 'development'),
      REG_Fuse_NoReload   = ( self.Phase ~= 'development'),
  }

  return true
end



function Fuse:addError(txt)
  assert(self ~= nil)
  assert(txt~=nil and txt~='')
  table.insert(self.errors,txt)
end



function Fuse:hasErrors()
  assert(self ~= nil, "call as INSTANCE:hasErrors()")
  return #self.errors > 0
end



function Fuse:isValid()
  assert(self ~= nil)
  if self:hasErrors() or self.FilePath==nil or self.FilePath=='' then
    return false
  end
  return true
end



function Fuse:getErrorText()
  assert(self ~= nil)

  if #self.errors == 0 then
    return ''
  end

  return self.errors[1]
end



function Fuse:getErrorsHTML()
  assert(self ~= nil)

  if #self.errors == 0 then
    return ''
  end

  local html = "Number of problems: ".. #self.errors .."<ul>\n"

  for i, err in ipairs(self.errors) do
    html = html .. "<li>".. err .. "</li>\n"
  end

  html = html .. "</ul>\n"

  return html
end



function Fuse:getErrorsMarkdown()
  assert(self ~= nil)

  if #self.errors == 0 then
    return ''
  end

  local md = "Number of problems: ".. #self.errors .."\n\n"

  for i, err in ipairs(self.errors) do
    md = md .. "- ".. err .. "\n"
  end

  md = md .. "\n"

  return md
end


function Fuse:getCompatibilityHTML()
  assert(self ~= nil)

  local function f(key,name)

    if self.Compatibility == nil then
      return '⬛ '..name..': <span style="color:red; ">NOT TESTED!</span><br />\n'
    end

    if self.Compatibility[key] == nil then
      return '⬛ '..name..': <span style="color:red; ">NOT TESTED!</span><br />\n'
    end

    if self.Compatibility[key] == true then
      return '🟩 '..name..': <span style="color:green; ">checked</span><br />\n'
    end

    if (self.CompatibilityIssues[key] or '') ~= '' then
      return '🟥 '..name..': <span style="color:red; ">'.. self.CompatibilityIssues[key] ..'</span><br />\n'
    end

    return '🟥 '..name..'<br />\n'
  end

  return
    f('macOS_Metal','macOS / Metal')..
    f('macOS_OpenCL','macOS / OpenCL')..
    f('Windows_CUDA','Windows / CUDA')..
    f('Windows_OpenCL','Windows / OpenCL')
end



function Fuse:print(indent)
  indent = indent and indent or ""

  print(indent.."Fuse:")
  print(indent.."  FilePath = '"..self.FilePath.."'")
  print(indent.."  DirName = '"..self.DirName.."'")
  print(indent.."  Category = '"..self.Category.."'")
  print(indent.."  Name = '"..self.Name.."'")
  print(indent.."  Author = '"..self.Author.."'")

  if self:hasErrors() then
    print(indent.."Errors:")
    for _, err in ipairs(self.errors) do
      print(indent.."  - "..err)
    end
  end

  print(indent.."Shadertoy:")
  print(indent.."  Name = '"..self.Shadertoy.Name.."'")
  print(indent.."  Author = '"..self.Shadertoy.Author.."'")
  print(indent.."  ID = '"..self.Shadertoy.ID.."'")
  print(indent.."  License = '"..self.Shadertoy.License.."'")

end



return Fuse
