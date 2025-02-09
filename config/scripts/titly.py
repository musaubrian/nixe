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
    if len(sys.argv) == 1:
        print(f"Invalid choice, {opts}")
    if len(sys.argv) > 1:
        choice = sys.argv[1]
        if choice not in opts:
            print(f"Invalid choice, {opts}")
        elif choice == opts[2]:
            main(to_yt_vids)
        elif choice == opts[1]:
            main(to_vids)
        else:
            main(to_music)
