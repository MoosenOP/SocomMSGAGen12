# SOCOM x MSGA GEN-12 Expansion — v1.1.0

A SOCOM-enhanced GEN-12 attachment and weapon expansion for **SPT 4.1.6** and **Make Shotguns Great Again**.

## Install

1. Install the required server mods: **SOCOM Expansion Core 0.1.x**, **Make Shotguns Great Again 1.20.x**, and **WTT ServerCommonLib 3.0.x**. Use their SPT 4.1.6-compatible releases. **SOCOM Armory** and its trader must be present to use the SOCOM trader offers.
2. Back up your existing `SPT_Runtime/user/mods/SocomMSGAGen12/` folder, if present. Remove older copies of the GEN-12 expansion; do not merge trial folders with the release.
3. Extract this ZIP into your SPT installation folder **containing `SPT_Runtime`**. The resulting mod path should be `SPT_Runtime/user/mods/SocomMSGAGen12/`.
4. Start the SPT server. Confirm it lists **SOCOM x MSGA GEN-12 Expansion, version 1.1.0**.

Do not copy files from this package into the underlying MSGA mod. Keep dependency mods independently installed.

## What's included

- SOCOM-enhanced GEN-12 receiver, barrel, magazine, and handguard options with purple inventory backgrounds.
- **7.25-inch PDW barrel**, with its dedicated model and working inventory preview.
- **7-inch SBS7 M-LOK handguards**, in standard and enhanced SOCOM variants; their front sight position can alternatively fit a compatible tactical light or laser.
- **Genesis-12 Suppressor**, a GEN-12-compatible SOCOM attachment.
- 18 component and weapon offers at **SOCOM loyalty level 3**.

## Selected balance values

| Item | Recoil modifier | Ergonomics |
| --- | ---: | ---: |
| SOCOM TTI Dracarys KeyMod-style handguards (JW4 Grey, Black, FDE) | -14% | +14 |
| SOCOM SBS7 M-LOK handguard | -9% | +19 |
| Standard SBS7 M-LOK handguard | -1% | +4 |
| Genesis-12 Suppressor | -22% | -7 |

See `CHANGELOG.md` for the v1.1.0 changes.

## Files

The `bundles/` folder contains the short barrel and SBS7 visual assets. `db/CustomItems/` stores item definitions; `db/TraderSOCOM/` stores trader listings. `bundles.json` registers the model bundles. The DLL handles item and trader registration. Do not change these paths without rebuilding the mod.

## Credits and compatibility

This is an add-on for the independently maintained **SPT**, **Make Shotguns Great Again**, **SOCOM Expansion Core**, **WTT ServerCommonLib**, and **SOCOM Armory** projects. All dependency mods retain their own licenses and distribution terms. This package does not include the dependency mods themselves.
