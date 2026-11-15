# SOCOM GENESIS-12

An SPT 4.1.6 weapon expansion that adds a separate SOCOM GENESIS-12 shotgun based on content from Make Shotguns Great Again (MSGA).

## Features

- Selectable semi-automatic and fully automatic fire at 600 RPM
- SOCOM trader availability at Loyalty Level 3
- Dedicated weapon and component variants
- Original MSGA GEN-12 is not replaced or modified
- Trader offer integration through [SOCOM Expansion Core](https://github.com/MoosenOP/SocomExpansionCore)

## Requirements

- SPT 4.1.6
- [SOCOM Armory — Unofficial SPT 4.1.6 Port](https://sp-mod.com/mod/3375/socom-armory-unofficial-spt-416-port)
- [SOCOM Expansion Core](https://github.com/MoosenOP/SocomExpansionCore)
- Make Shotguns Great Again (MSGA)
- Dependencies of the above mods, as required by their respective releases

## Source files

This repository tracks the Test 04B Name Cleanup source checkpoint. The source files are in the `GEN12/source` folder to retain the original tested build-kit layout. The distribution ZIP is published separately under GitHub Releases.

The C# project expects a sibling `CORE/source/SocomExpansionCore.csproj` and a `references/` directory in the build-kit root. These are provided or prepared separately from this repository. Third-party reference DLLs are not distributed here.

## License and credits

This repository includes the MIT license for its own integration code. The SOCOM Armory and MSGA mods, their assets, and all third-party dependencies retain their own licenses and credits.

## Source checkpoint

Test 04B — Name Cleanup. The latest change renamed the in-game SOCOM weapon to **SOCOM GENESIS-12** without changing its gameplay mechanics.
