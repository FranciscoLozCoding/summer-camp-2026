#!/usr/bin/env bash
# Strip build-machine absolute paths out of a graphify baseline tarball.
# Repacked artifacts must not carry the packager's home directory, and
# .graphify_root must point at the documented install location rather than at
# whatever machine happened to build the graph.
set -euo pipefail
TARBALL="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
INSTALL_ROOT="${2:-\$HOME/.hermes/profiles/sage}"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

tar -xzf "$TARBALL" -C "$WORK"
DIR="$WORK/graphify-out"
[[ -d "$DIR" ]] || { echo "no graphify-out/ in $TARBALL" >&2; exit 1; }

# .graphify_root: point at the install location, not the build machine.
if [[ -f "$DIR/.graphify_root" ]]; then
  printf '%s\n' "$INSTALL_ROOT" > "$DIR/.graphify_root"
fi

# Everything else: rewrite any /Users/<name>/... or /home/<name>/... prefix that
# ends at the profile dir down to the install root.
while IFS= read -r f; do
  INSTALL_ROOT="$INSTALL_ROOT" perl -pi -e 's{(?:/Users|/home)/[^/\s"]+/[^\s"]*?hermes-profile}{$ENV{INSTALL_ROOT}}g' "$f"
done < <(grep -rlE '(/Users|/home)/[^/[:space:]"]+/' "$DIR" 2>/dev/null || true)

remaining="$( { grep -rlE '(/Users|/home)/[^/[:space:]"]+/' "$DIR" 2>/dev/null || true; } | wc -l | tr -d ' ')"
if [[ "$remaining" != "0" ]]; then
  echo "WARNING: $remaining file(s) still contain absolute home paths:" >&2
  grep -rlE '(/Users|/home)/[^/[:space:]"]+/' "$DIR" >&2
fi

( cd "$WORK" && tar -czf "$TARBALL" graphify-out )
echo "sanitized: $TARBALL"
