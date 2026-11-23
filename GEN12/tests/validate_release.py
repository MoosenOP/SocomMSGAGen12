from pathlib import Path
import json,zipfile,sys,re
root=Path(__file__).resolve().parents[1]
item_path=root/'source/Resources/db/CustomItems/gen12_socom_clones.json'
items=json.loads(item_path.read_text(encoding='utf-8'))
assert len(items)==19
assert all(items[i]['overrideProperties']['Recoil']==-14 for i in ['bb7adcd5a60801219d5b8f8d','daf70de9cf9cf900b3a4d2de','8afbcab186d9ca43b539c927'])
assert items['6a18f1e04e75b912c237aa27']['overrideProperties']['Recoil']==-9
assert items['6a18f1e04e75b912c237aa27']['overrideProperties']['Ergonomics']==19
assert items['6a18f1e04e75b912c237aa2c']['overrideProperties']['Recoil']==-1
assert items['6a18f1e04e75b912c237aa2c']['overrideProperties']['Ergonomics']==4
assert all('Test build' not in v['locales']['en']['description'] for v in items.values())
assert all('tested geometry' not in v['locales']['en']['description'] for v in items.values())
offers=json.loads((root/'source/Resources/db/TraderSOCOM/additional_offers.json').read_text(encoding='utf-8'))
assert set(offers['loyal_level_items']).issubset(set(items))
assert len(offers['items'])==len(offers['barter_scheme'])==len(offers['loyal_level_items'])==18
manifest=json.loads((root/'assets/bundles.json').read_text(encoding='utf-8'))
keys={x['key'] for x in manifest['manifest']}
assert keys=={p.name for p in (root/'assets/bundles').glob('*.bundle')}
print('PASS: 19 items, targeted recoil/ergonomics, 18 trader offers, 2 bundles, no test descriptions')

# Release version must agree in the project metadata, source registration, and build artifact name.
assert '<Version>1.1.0</Version>' in (root/'source/SocomMSGAGen12.csproj').read_text(encoding='utf-8')
assert 'new("1.1.0")' in (root/'source/Mod.cs').read_text(encoding='utf-8')
assert 'SocomMSGAGen12_v1.1.0_SPT416.zip' in (root/'BUILD_RELEASE.ps1').read_text(encoding='utf-8')
print('PASS: v1.1.0 version numbers consistent')
