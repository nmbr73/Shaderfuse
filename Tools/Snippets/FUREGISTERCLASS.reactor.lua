
  dctlfuse_name, CT_SourceTool, {
  REGS_Category      = "Shadertoys\\"..dctlfuse_category,
  REGS_OpIconString  = "ST-"..shadertoy_id,
  REGS_OpDescription = "Shadertoy '"..shadertoy_name.."' (ID: "..shadertoy_id..") created by "..shadertoy_author.." and ported by "..dctlfuse_author..(shadertoy_license == "" and ". Copyright "..shadertoy_author.." (CC BY-NC-SA 3.0)" or ". "..shadertoy_license)..". This port is by no means meant to take advantage of anyone or to do anyone wrong : Contact us on Discord (https://discord.gg/75FUn4N4pv) and/or GitHub (https://github.com/nmbr73/Shadertoys) if you see your rights abused or your intellectual property violated by this work.",
  REG_Fuse_NoEdit    = true,
  REG_Fuse_NoReload  = true,
  REGS_Company       = dctlfuse_company==nil and dctlfuse_author or dctlfuse_company,
  REGS_URL           = dctlfuse_authorurl==nil and "https://nmbr73.github.io/Shadertoys/" or dctlfuse_authorurl,
--REGS_URL           = 'https://nmbr73.github.io/Shadertoys/Shaders/'..dctlfuse_category..'/'..dctlfuse_name..'.html',
  REG_Version        = dctlfuse_versionNo==nil and 1 or dctlfuse_versionNo,
