#!/usr/bin/env python3

import os
import sys
import re
import subprocess
import json

home = os.getenv("HOME")
to_music = f"{home}/Music"
to_vids = f"{home}/Videos"
to_yt_vids = f"{home}/Videos/yt"


def get_tags(filepath):
    """Extract artist and title tags via ffprobe."""
    try:
        result = subprocess.run(
            ["ffprobe", "-v", "quiet", "-show_entries",
             "format_tags=artist,title,album_artist",
             "-of", "json", filepath],
            capture_output=True, text=True, timeout=5
        )
        data = json.loads(result.stdout)
        tags = data.get("format", {}).get("tags", {})
        return {k.lower(): v for k, v in tags.items()}
    except Exception:
        return {}


def clean_yt(path):
    """Original: strip [metadata] from YouTube files"""
    files = os.listdir(path)
    c = 0
    for file in files:
        if file.__contains__("["):
            clean = re.sub(r"\s*\[.*?\]\s*", "", file)
            os.rename(f"{path}/{file}", f"{path}/{clean}")
            c += 1
    print(f">>> {c} files renamed")


def clean_name(name):
    """Strip junk suffixes and normalize a filename stem."""
    name = re.sub(r'\s*\(Official\s+(Music\s+)?Video\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Official\s+Lyric\s+Video\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Official\s+Audio\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Lyric Video\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Lyrics\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Explicit\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Audio\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(HD\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(HQ\)', '', name, flags=re.I)
    name = re.sub(r'\s*\(Remaster[^)]*\)', '', name, flags=re.I)
    name = re.sub(r'\s*\([^)]*\.com\)', '', name)
    name = re.sub(r'\s*\[.*?\]', '', name)
    # Strip leading track numbers (01, 02, etc.)
    name = re.sub(r'^\d{1,2}\.\s*', '', name)
    name = re.sub(r'^\d{1,2}\s*-\s*', '', name)
    # Remove trailing YouTube video IDs (11 char alphanumeric)
    name = re.sub(r'\s+[a-zA-Z0-9_-]{11}$', '', name)
    # Remove trailing bitrate markers like (128)
    name = re.sub(r'\s*\(\d{2,3}\)\s*$', '', name)
    # Normalize "ft."/"Feat."/"featuring" -> "feat."
    name = re.sub(r'\bft\.?\s+', 'feat. ', name, flags=re.I)
    name = re.sub(r'\bFeat\.\s+', 'feat. ', name)
    name = re.sub(r'\bfeaturing\s+', 'feat. ', name, flags=re.I)
    # Clean trailing dashes, extra spaces
    name = name.strip().rstrip('-').strip()
    name = re.sub(r'\s+', ' ', name)
    return name


def parse_artist_title(filename):
    """Try to split 'Artist - Title' from a filename stem."""
    name = os.path.splitext(filename)[0]
    for sep in [' - ', ' – ', ' — ']:
        if sep in name:
            parts = name.split(sep, 1)
            return parts[0].strip(), parts[1].strip()
    return None, name


def clean_music(path, dry_run=True):
    """Clean music filenames: normalize to 'Artist - Title.ext' format.
    Uses ffprobe metadata when available, falls back to filename parsing."""
    all_files = sorted(os.listdir(path))
    audio_files = []
    for f in all_files:
        fp = os.path.join(path, f)
        if f.startswith('.') or os.path.isdir(fp):
            continue
        if re.search(r'\.(mp3|flac|m4a|wav|aac|ogg)$', f, re.I):
            audio_files.append(f)

    total = len(audio_files)
    renamed = []
    skipped = []

    for i, file in enumerate(audio_files, 1):
        print(f"\r\033[Kscanning [{i}/{total}] {file[:60]}", end="", flush=True)

        full_path = os.path.join(path, file)
        ext = os.path.splitext(file)[1]
        # Fix double extensions like .m4a.mp3
        if file.endswith('.m4a.mp3'):
            ext = '.mp3'

        original = file

        # Try ffprobe metadata first
        tags = get_tags(full_path)
        tag_artist = tags.get('artist', '').strip()
        tag_title = tags.get('title', '').strip()

        # Clean " - Topic" from YouTube auto-generated artist names
        tag_artist = re.sub(r'\s*-\s*Topic$', '', tag_artist)

        # Clean the title tag
        if tag_title:
            tag_title = clean_name(tag_title)

        # Parse from filename as fallback
        fn_artist, fn_title = parse_artist_title(file)
        if fn_title:
            fn_title = clean_name(fn_title)
        if fn_artist:
            fn_artist = clean_name(fn_artist)

        # Pick best artist and title (prefer tags over filename)
        artist = tag_artist or fn_artist or ''
        title = tag_title or fn_title or ''

        # If tag title has "Artist - Title" embedded, split it out
        if title and ' - ' in title and tag_artist:
            parts = title.split(' - ', 1)
            if parts[0].strip().lower() in tag_artist.lower():
                title = parts[1].strip()

        if artist and title:
            new_file = f"{artist} - {title}{ext}"
        elif title:
            new_file = f"{title}{ext}"
        else:
            continue

        # Normalize unicode separators
        new_file = new_file.replace('–', '-').replace('—', '-')
        # Collapse multiple spaces
        new_file = re.sub(r'\s+', ' ', new_file).strip()

        if new_file != original:
            renamed.append((original, new_file))
            if not dry_run:
                new_path = os.path.join(path, new_file)
                if os.path.exists(new_path):
                    skipped.append((original, new_file, "target exists"))
                    continue
                os.rename(full_path, new_path)

    # Clear progress line
    print(f"\r\033[K", end="")

    # Print results
    print(f"{'[DRY RUN]' if dry_run else '[APPLIED]'} Music cleanup summary:")
    print(f"  Would rename: {len(renamed)}")
    print(f"  Skipped: {len(skipped)}")

    if renamed:
        print(f"\nChanges:")
        for old, new in renamed[:20]:  # Show first 20
            print(f"  {old} → {new}")
        if len(renamed) > 20:
            print(f"  ... and {len(renamed) - 20} more")

    return renamed


if __name__ == "__main__":
    opts = ["m", "v", "y"]
    if len(sys.argv) < 2:
        print(f"Usage: titly.py [m|v|y] [--apply]")
        print(f"  m:  Clean music (dry-run by default, --apply to rename)")
        print(f"  v:  Clean videos")
        print(f"  y:  Clean YouTube videos")
        sys.exit(1)

    choice = sys.argv[1]
    apply = "--apply" in sys.argv

    paths = {"y": to_yt_vids, "v": to_vids, "m": to_music}

    if choice not in paths:
        print(f"Invalid choice. Please use one of: {opts}")
        sys.exit(1)

    if choice == "m":
        clean_music(paths[choice], dry_run=not apply)
    else:
        clean_yt(paths[choice])
