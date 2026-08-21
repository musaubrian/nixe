#!/usr/bin/env python

import json, sys

def minify(src, dst):
    with open(src) as f:
        data = json.load(f)
    with open(dst, 'w') as f:
        json.dump(data, f, separators=(',', ':'))

if __name__ == "__main__":
    src, dest = sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else sys.argv[1]
    if src == dest:
        print("[info]: Overwriting src")

    minify(src, dest)
