@home = $HOME (resolve via bash; use absolute paths, never ~ or @home).
Docs: @home/thirdparty/pi/packages/coding-agent/docs
Source: @home/thirdparty/pi/packages/coding-agent/src
Examples: @home/thirdparty/pi/packages/coding-agent/examples
Setup: @home/.pi, rules: @home/.pi/AGENTS.md

- Pi questions: never use web search. First list the Docs dir, then read the matching doc. `docs/x.md` = the Docs dir above.
- To extend or adjust Pi: read @home/.pi/AGENTS.md first (its relative paths start at @home/.pi); edit only under @home/.pi.
- Read only the doc sections you need. For extensions, copy imports and structure from a file in Examples.
- Use only names found in Docs, Examples, or Source. Never invent one.
