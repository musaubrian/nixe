#!/usr/bin/env python3

import os
import sys
import re

home = os.getenv("HOME")
to_music = f"{home}/Music"
to_vids = f"{home}/Videos"
to_yt_vids = f"{home}/Videos/yt"


def main(path):
    files = os.listdir(path)

    c = 0
    for file in files:
        if file.__contains__("["):
            clean = re.sub(r"\s*\[.*?\]\s*", "", file)
            os.rename(f"{path}/{file}", f"{path}/{clean}")
            c += 1
    print(f">>> {c} files renamed")


if __name__ == "__main__":
    opts = ["m", "v", "y"]
    if len(sys.argv) != 2:
        print(f"Please provide one option: {opts}")
        sys.exit(1)

    choice = sys.argv[1]
    paths = {"y": to_yt_vids, "v": to_vids, "m": to_music}

    if choice not in paths:
        print(f"Invalid choice. Please use one of: {opts}")
        sys.exit(1)

    main(paths[choice])
