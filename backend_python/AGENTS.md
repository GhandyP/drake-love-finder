# BACKEND PYTHON KNOWLEDGE BASE

## OVERVIEW
Flat Python CLI area: executable scripts plus planning/product docs. Handwritten, stdlib-only, no package layout, no tests.

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| Main CLI flow | `backend_python/drake_equation_love_finder.py` | Calculator + prompt loop + results |
| Duplicate CLI flow | `backend_python/drake.py` | Near-copy; drift risk |
| Product constraints | `backend_python/drake_equation_love_finder_prd.md` | Explicitly says no external Python deps |
| Planned testing | `backend_python/drake_equation_love_finder_plan.md` | Aspirational only; not implemented |

## CONVENTIONS
- Script-first structure; run directly with `python3 backend_python/drake_equation_love_finder.py`.
- Both scripts contain full app flow instead of shared module + thin wrapper.
- User input is interactive terminal input; no backend service/API layer exists.

## ANTI-PATTERNS
- Do not add third-party Python packages casually; product doc constrains backend to standard library.
- Do not patch only one of the duplicate scripts unless divergence is intentional and documented.
- Do not assume tests exist; verify manually or add tests explicitly.

## COMMANDS
```bash
python3 backend_python/drake_equation_love_finder.py
python3 backend_python/drake.py
python3 -m py_compile backend_python/drake_equation_love_finder.py backend_python/drake.py
```

## NOTES
- `__pycache__/` here is generated; ignore for maintenance.
- If backend work grows, first cleanup target is consolidating duplicate entrypoints.
