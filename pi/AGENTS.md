# PI AGENT WORKSPACE (Yanked from dmulroy)

npm workspace for pi agent extensions. TypeScript, ESM-only.

## STRUCTURE

```
.pi/
├── package.json          # Workspace root: workspaces = ["agent/extensions/*"]
├── tsconfig.json         # Strict, bundler mode, ESNext, noEmit
├── agent/
│   ├── settings.json     # Provider, model, theme, packages, interview config
│   └── extensions/       # Local TypeScript extensions
```

## WHERE TO LOOK

| Task                          | Location                                       |
| ------                        | ----------                                     |
| Change default model/provider | `agent/settings.json`                          |
| Add pi package                | `agent/settings.json` → `packages[]`           |
| Create extension              | `agent/extensions/<name>/` with `package.json` |
| Create standalone extension   | `agent/extensions/<name>.ts`                   |
| Create skill                  | `agent/skills/<name>/SKILL.md`                 |

## CONVENTIONS

- Extensions as npm workspace packages: each has own `package.json`
- Standalone extensions: single `.ts` file in `extensions/`
- ESM only: `"type": "module"` everywhere
- Dependencies: `@earendil-works/pi-ai`, `@earendil-works/pi-coding-agent`, `@earendil-works/pi-tui`
- TypeScript strict mode: `noUncheckedIndexedAccess`, `noImplicitOverride`

## ANTI-PATTERNS

- Installing deps at workspace root for extension-specific needs (use per-package)
- Committing `node_modules/` (gitignored per-extension)
- Adding runtime state files to git (most of `agent/*` is gitignored, only extensions/settings un-ignored)

## GITIGNORE PATTERN

Most of `agent/` is gitignored by default. Tracked files are explicitly un-ignored:
- `agent/extensions/**` (but `node_modules/` within are re-ignored)
- `agent/themes/*.json`
