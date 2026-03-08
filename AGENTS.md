# PROJECT KNOWLEDGE BASE

**Generated:** 2026-03-07
**Commit:** 360c147
**Branch:** master

## OVERVIEW
Small dual-surface repo: Python CLI love-probability calculator + Flutter frontend for the same local calculation flow. No CI, no monorepo tooling, no root orchestrator.

## STRUCTURE
```text
drake_love_finder/
├── backend_python/      # handwritten Python CLI + planning docs
├── frontend_flutter/    # Flutter app; lib/test are maintained, platforms mostly generated
├── .ruff_cache/         # generated tool cache
└── __pycache__/         # generated Python bytecode cache
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| Python CLI behavior | `backend_python/drake_equation_love_finder.py` | Canonical-looking backend script; shell-runnable |
| Duplicate backend entry | `backend_python/drake.py` | Near-duplicate of the main backend script |
| Flutter UI | `frontend_flutter/lib/main.dart` | Main maintained frontend source |
| Flutter widget tests | `frontend_flutter/test/widget_test.dart` | Only active automated tests |
| Flutter config | `frontend_flutter/pubspec.yaml` | `publish_to: "none"`; app-only package |
| Flutter linting | `frontend_flutter/analysis_options.yaml` | Default `flutter_lints` include |
| Product constraints | `backend_python/drake_equation_love_finder_prd.md` | Backend should avoid external Python deps |

## CODE MAP
| Symbol | Type | Location | Role |
|--------|------|----------|------|
| `LoveCalculator` | class | `backend_python/drake_equation_love_finder.py` | Core probability math + insights |
| `LoveFinderApp` | class | `backend_python/drake_equation_love_finder.py` | Interactive CLI workflow |
| `DrakeLoveFinderApp` | class | `frontend_flutter/lib/main.dart` | Flutter app root |
| `LoveFinderHomePage` | class | `frontend_flutter/lib/main.dart` | Main single-screen UI |
| `_FactorSlider` | widget | `frontend_flutter/lib/main.dart` | Slider presentation + helper copy |

## CONVENTIONS
- Run from subprojects, not repo root: Python via `python3 backend_python/...`; Flutter via `cd frontend_flutter && flutter ...`.
- Flutter project commits metadata/template files (`.metadata`, `.iml`) while `.gitignore` excludes whole platform dirs; this is not standard Flutter repo policy.
- Test coverage is frontend-only and lightweight; no Python test suite exists.

## ANTI-PATTERNS (THIS PROJECT)
- Do not add non-stdlib Python dependencies unless product constraints are explicitly changed.
- Do not edit both `backend_python/drake.py` and `backend_python/drake_equation_love_finder.py` independently without checking for drift.
- Do not assume Flutter platform folders contain meaningful custom native logic; most are scaffold-level.
- Do not hardcode `/home/ghandy/.local/flutter`; prefer `flutter` on `PATH` in docs/scripts.

## UNIQUE STYLES
- Frontend is a single-file Flutter UI (`lib/main.dart`) plus a single widget-test file.
- Backend remains script-first rather than package-first.
- Planning/product docs live beside executable backend code.

## COMMANDS
```bash
# Python CLI
python3 backend_python/drake_equation_love_finder.py
python3 backend_python/drake.py

# Flutter
cd frontend_flutter && flutter pub get
cd frontend_flutter && flutter analyze
cd frontend_flutter && flutter test
cd frontend_flutter && flutter run
cd frontend_flutter && flutter run -d web-server
```

## NOTES
- No `.github/workflows`, `Makefile`, `pyproject.toml`, or Flutter workspace manager present.
- `frontend_flutter/README.md` is still template-level; do not rely on it for project-specific instructions.
- Generated clutter (`build/`, caches, platform scaffolding) is high relative to handwritten code; focus reviews on `backend_python/`, `frontend_flutter/lib`, and `frontend_flutter/test`.
