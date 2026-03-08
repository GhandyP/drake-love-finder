# FRONTEND FLUTTER KNOWLEDGE BASE

## OVERVIEW
Single-screen Flutter app. Real maintenance happens in `lib/` and `test/`; platform directories are currently scaffold-level.

## STRUCTURE
```text
frontend_flutter/
├── lib/          # handwritten app source; primary target
├── test/         # handwritten widget tests
├── pubspec.yaml  # app config; `publish_to: "none"`
├── analysis_options.yaml  # default flutter_lints include
└── android/ ios/ linux/ macos/ web/ windows/  # mostly generated scaffolding
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| UI behavior | `frontend_flutter/lib/main.dart` | Entire app currently lives here |
| Widget regression checks | `frontend_flutter/test/widget_test.dart` | Only active tests |
| Dependency/tooling rules | `frontend_flutter/pubspec.yaml` | Minimal deps; app not publishable |
| Lint baseline | `frontend_flutter/analysis_options.yaml` | Default Flutter lints only |

## CONVENTIONS
- Single-file UI architecture: avoid inventing extra layers unless the file becomes clearly unmanageable.
- Run Flutter commands from `frontend_flutter/`.
- Use Material 3 defaults and theme tokens; custom lint rules are not present.

## ANTI-PATTERNS
- Do not spend time documenting/editing platform folders unless native customization is introduced.
- Do not hardcode machine-local `FLUTTER_ROOT`; use `flutter` on `PATH` for commands/docs.
- Do not trust the default `README.md`; it is template text, not project guidance.
- Do not assume test depth is high; current coverage is widget-smoke level.

## COMMANDS
```bash
cd frontend_flutter && flutter pub get
cd frontend_flutter && flutter analyze
cd frontend_flutter && flutter test
cd frontend_flutter && flutter run
cd frontend_flutter && flutter run -d web-server
```

## NOTES
- `android/`, `ios/`, `linux/`, `macos/`, `windows/`, and `web/` are mostly generated scaffolding right now.
- `build/`, `.dart_tool/`, `.idea/`, `.metadata`, and `.iml` are support/generated clutter; review source changes mainly in `lib/` and `test/`.
