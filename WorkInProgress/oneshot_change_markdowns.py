#!/usr/bin/env python
from pathlib import Path
import sys
import re

basepath = Path('Shaders')

pattern_compatibiliy = re.compile(r'##\s+(Compatibility|Compability)\s*\n- \[([x ])\] Tested on macOS/Metal(| [^\n]+)\n- \[([x ])\] Tested on macOS/OpenCL(| [^\n]+)\n- \[([xX ])\] Tested on Windows/Cuda\n- \[([xX ])\] Tested on Windows/OpenCL(| [^\n]+)\s*$')

# [![Download Installer](https://img.shields.io/static/v1?label=Download&message=Heartdemo-Installer.lua&color=blue)](https://github.com/nmbr73/Shadertoys/releases/download/V1.1/Heartdemo-Installer.lua "Installer")
pattern_installer = re.compile(r'\[!\[Download Installer\]\(https://img.shields.io/static/v1\?label=Download&message=[^\)]+\)\]\(https://github.com/nmbr73/Shadertoys/releases/download/V1.1/[^"]+"Installer"\)')

pattern_headline1 = re.compile(r'^#[^\n]+\n+')
pattern_headline2 = re.compile(r'^[^\n]+\n=+\n+')
pattern_shaderinfo = re.compile(r'Based on \'[^\']+\' by ([A-Za-z ]*)\[[^\]]+\]\([^\)]+\) and ported by (|ported by)\s*\[[^\]]+\]\([^\)]+\)\.*')
pattern_dctlvariable = re.compile(r'(\n\s*local\s+dctlfuse_[a-z][A-Za-z]+\s*=[^\n]+)')
pattern_shadervariable = re.compile(r'(\n\s*local\s+shadertoy_[a-z][A-Za-z]+\s*=[^\n]+)')



sfi_match ="""
    Compatibility = {
        macOS_Metal    = nil,  -- not tested yet
        macOS_OpenCL   = nil,  -- not tested yet
        Windows_CUDA   = true, -- works
        Windows_OpenCL = true, -- works
    },
"""

numfuses = 0
nomatch = 0
numstdinfo = 0

for fuse in basepath.rglob("*.fuse"):

    numfuses += 1

    md = fuse.parent.joinpath(f"{fuse.stem}.md")

    with md.open() as f:
        md_content = f.read()

    if not md_content:
        print(f"dang '{md}'")
        break

    md_content_original = md_content

    match = re.search(pattern_compatibiliy,md_content)

    if not match:
        nomatch=nomatch+1
        # print(f"NO MATCH file '{md}'")
        continue

    md_match = match[0]

    macos_metal     = match[2] != ' '
    macos_opencl    = match[4] != ' '
    windows_cuda    = match[6] != ' '
    windows_opencl  = match[7] != ' '

    reason_macos_metal    = match[3]
    reason_macos_opencl   = match[5]
    reason_windows_opencl = match[8]

    if (macos_metal and reason_macos_metal != '') or (macos_opencl and reason_macos_opencl) or (windows_opencl and reason_windows_opencl):
        print(f"outch '{md}'")
        break

    sfi = fuse.parent.joinpath(f"{fuse.stem}.sfi")

    with sfi.open() as f:
        sfi_content = f.read()

    if not sfi_content:
        print(f"boom '{sfi}'")
        break

    sfi_content_original = sfi_content

    pos = sfi_content.find(sfi_match)

    if pos < 0:
        print(f"grrr '{sfi}'")
        break

    sfi_replacement = None

    if macos_metal and macos_opencl and windows_cuda and windows_opencl:
        sfi_replacement =  "\n    Compatibility = 15,\n"
    else:
        macos_metal     = 'true' if macos_metal else (f'"{reason_macos_metal.strip()}"' if reason_macos_metal!='' else 'nil')
        macos_opencl     = 'true' if macos_opencl else (f'"{reason_macos_opencl.strip()}"' if reason_macos_opencl!='' else 'nil')
        windows_cuda     = 'true' if windows_cuda else 'nil'
        windows_opencl     = 'true' if windows_opencl else (f'"{reason_windows_opencl.strip()}"' if reason_windows_opencl!='' else 'nil')

        sfi_replacement =   "\n    Compatibility = {\n" \
                    + f"        macOS_Metal    = {macos_metal},\n" \
                    + f"        macOS_OpenCL   = {macos_opencl},\n" \
                    + f"        Windows_CUDA   = {windows_cuda},\n" \
                    + f"        Windows_OpenCL = {windows_opencl},\n" \
                    +  "    },\n"

        sfi_replacement = sfi_replacement.replace(':bomb:','💣')



    sfi_content = sfi_content.replace(sfi_match,sfi_replacement,1)
    md_content = md_content.replace(md_match,'',1)


    md_content = re.sub(pattern_installer,'',md_content)
    md_content = re.sub(pattern_headline1,'',md_content.strip())
    md_content = re.sub(pattern_headline2,'',md_content.strip())
    md_content = re.sub(pattern_shaderinfo,'',md_content)
    md_content = md_content.strip()

    md_content =     "<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->\n\n" + md_content \
                +"\n\n<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->\n"



    src = fuse.parent.joinpath(f"{fuse.stem}.fuse")

    with src.open() as f:
        src_content = f.read()

    if not src_content:
        print(f"knartz '{src}'")
        break

    src_content_original = src_content

    src_content = src_content.replace('\n-- MANDATORY -----------------------------------------------------------------\n','\nlocal ShaderFuse = require("Shaderfuse/ShaderFuse")\nShaderFuse.init()\n',1)
    src_content = src_content.replace('\n-- OPTIONAL ------------------------------------------------------------------\n','\n',1)
    src_content = src_content.replace('\nFC_DEVEVELOP = true\n','\n',1)
    src_content = src_content.replace('\nFC_DEVEVELOP = false\n','\n',1)
    src_content = re.sub(pattern_dctlvariable,'',src_content)
    src_content = re.sub(pattern_shadervariable,'',src_content)

    a = src_content.find('-- >>> SCHNIPP::FUREGISTERCLASS')
    if a != -1:
        b = src_content.find('-- <<< SCHNAPP::FUREGISTERCLASS',a)
        if b != -1:
            src_content = src_content[0:a] + '  ShaderFuse.FuRegister.Name, CT_SourceTool, {\n  ShaderFuse.FuRegister.Attributes,\n' + src_content[b+31:]

            src_content = re.sub(r'FuRegisterClass\(\s+ShaderFuse\.FuRegister\.Name,','FuRegisterClass(ShaderFuse.FuRegister.Name,',src_content)
            src_content = re.sub(r'  ShaderFuse.FuRegister.Attributes,\s+','  ShaderFuse.FuRegister.Attributes,\n  ',src_content)
        else:
            a = -1


    a = src_content.find('-- /* ====================== DO NOT TOUCH OR APPEND ANY CODE HERE ===========================================\n')

    if a != -1:
        src_content = src_content[0:a] + src_content[a+110:]

    a = src_content.find('-- >>> SCHNIPP::SHADERFUSECONTROLS')

    if a != -1:
        src_content = src_content[0:a]

    # with src.open('w') as f:
    #     f.write(src_content)
    # break


    if src_content_original == src_content:
        print(f"unchanged '{src}'")

    if md_content_original == md_content:
        print(f"unchanged '{md}'")

    if sfi_content_original == sfi_content:
        print(f"unchanged '{sfi}'")

    if False:
        with sfi.open('w') as f:
            f.write(sfi_content)

        with md.open('w') as f:
            f.write(md_content)

        if src_content_original != src_content:
            with src.open('w') as f:
                f.write(src_content)


print(f"numfuses = {numfuses}")
print(f"nomatch = {nomatch}")
print(f"numstdinfo = {numstdinfo}")
