#!/usr/bin/env python
from pathlib import Path
import sys
import re

basepath = Path('Shaders')


numfuses = 0

for fuse in basepath.rglob("*.fuse"):

    numfuses += 1

    md = fuse.parent.joinpath(f"{fuse.stem}.md")

    with md.open() as f:
        md_content = f.read()

    if not md_content:
        print(f"dang '{md}'")
        break

    md_content_original = md_content


    md_content = md_content.replace("<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->","",1)
    md_content = md_content.replace("<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->","",1)
    md_content = md_content.strip()


    if md_content_original == md_content:
        print(f"unchanged '{md}'")


    if False:
        if md_content_original != md_content:
            with md.open('w') as f:
                f.write(md_content)


print(f"numfuses = {numfuses}")
