# Building from source

Requires Windows PowerShell 5.1, .NET 10 SDK, and a working SPT 4.1.6 installation with SOCOM Expansion Core, WTT ServerCommonLib, and MSGA.

From this source kit directory:

```powershell
.\BUILD_RELEASE.ps1 -SptRoot 'D:\SPT 4.1.6'
```

The build script copies its reference libraries from the installed SPT runtime (none are included here), compiles the C# project, and creates `SocomMSGAGen12_v1.1.0_SPT416.zip` with portable forward-slash ZIP paths.

Source layout:

- `source/` — mod code, item definitions, trader offers
- `assets/` — two Unity AssetBundles and bundle manifest
- `tests/` — structural validation
- `README.md`, `CHANGELOG.md` — player documentation embedded in the release

Run `python tests/validate_release.py` for source-side data validation. Use the actual SPT server to verify the compiled mod loads as version 1.1.0.
