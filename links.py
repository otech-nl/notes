# -*- coding: utf-8 -*-
from glob import glob
import re
import sys


def md2org(match):
    groups = match.groups()
    return f'[[{groups[1]}][{groups[0]}]]'


md_files = sys.argv[1:] or glob('*.md')
print('Processing files: ', md_files)

for md_file in md_files:
    try:
        with open(md_file, 'r') as f:
            md = f.read()
    except FileNotFoundError:
        print(f'File "{md_file}" could not be read')
        sys.exit()

    org_file = re.sub(r'.md$', '.org', md_file)
    print(f'Converting links in {md_file} to {org_file}')
    org = re.sub(r'\[([^\]]*)\]\(([^)]*)\)', md2org, md)
    with open(org_file, 'a') as f:
        f.write(org)
