param([Parameter(Mandatory=$true)][string]$SptRoot)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$root = $PSScriptRoot
$runtime = Join-Path $SptRoot 'SPT_Runtime'
if (!(Test-Path $runtime)) { throw "Could not find SPT_Runtime at $runtime" }
if (!(Get-Command dotnet -ErrorAction SilentlyContinue)) { throw 'Install .NET 10 SDK and retry.' }
$refs = Join-Path $root 'references'
New-Item -ItemType Directory -Force -Path $refs | Out-Null
$deps = @{
    'SPTarkov.Common.dll'        = (Join-Path $runtime 'SPTarkov.Common.dll')
    'SPTarkov.DI.dll'            = (Join-Path $runtime 'SPTarkov.DI.dll')
    'SPTarkov.Reflection.dll'    = (Join-Path $runtime 'SPTarkov.Reflection.dll')
    'SPTarkov.Server.Core.dll'   = (Join-Path $runtime 'SPTarkov.Server.Core.dll')
    'SemanticVersioning.dll'    = (Join-Path $runtime 'SemanticVersioning.dll')
    'WTT-ServerCommonLib.dll'    = (Join-Path $runtime 'user/mods/WTT-ServerCommonLib/WTT-ServerCommonLib.dll')
    'SocomExpansionCore.dll'     = (Join-Path $runtime 'user/mods/SocomExpansionCore/SocomExpansionCore.dll')
}
foreach($name in $deps.Keys) {
    $path = $deps[$name]
    if (!(Test-Path $path)) { throw "Missing build dependency: $path" }
    Copy-Item -LiteralPath $path -Destination (Join-Path $refs $name) -Force
    Write-Host "Reference $name <- $path"
}
$project = Join-Path $root 'source/SocomMSGAGen12.csproj'
& dotnet build $project -c Release -v minimal
if ($LASTEXITCODE -ne 0) { throw "dotnet build failed ($LASTEXITCODE); do not install." }
$dll = Join-Path $root 'source/bin/Release/net10.0/SocomMSGAGen12.dll'
if (!(Test-Path $dll)) { throw "Build produced no DLL at $dll" }
$stage = Join-Path $root 'release_stage'
if (Test-Path $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
$mod = Join-Path $stage 'SPT_Runtime/user/mods/SocomMSGAGen12'
$null = New-Item -ItemType Directory -Force -Path $mod
$null = New-Item -ItemType Directory -Force -Path (Join-Path $mod 'bundles')
$null = New-Item -ItemType Directory -Force -Path (Join-Path $mod 'db/CustomItems')
$null = New-Item -ItemType Directory -Force -Path (Join-Path $mod 'db/TraderSOCOM')
Copy-Item -LiteralPath $dll -Destination (Join-Path $mod 'SocomMSGAGen12.dll')
Copy-Item -LiteralPath (Join-Path $root 'assets/bundles.json') -Destination (Join-Path $mod 'bundles.json')
Copy-Item -Path (Join-Path $root 'assets/bundles/*.bundle') -Destination (Join-Path $mod 'bundles')
Copy-Item -LiteralPath (Join-Path $root 'source/Resources/db/CustomItems/gen12_socom_clones.json') -Destination (Join-Path $mod 'db/CustomItems/gen12_socom_clones.json')
Copy-Item -LiteralPath (Join-Path $root 'source/Resources/db/TraderSOCOM/additional_offers.json') -Destination (Join-Path $mod 'db/TraderSOCOM/additional_offers.json')
Copy-Item -LiteralPath (Join-Path $root 'README.md') -Destination (Join-Path $mod 'README.md')
Copy-Item -LiteralPath (Join-Path $root 'CHANGELOG.md') -Destination (Join-Path $mod 'CHANGELOG.md')
$archive = Join-Path $root 'SocomMSGAGen12_v1.1.0_SPT416.zip'
if (Test-Path $archive) { Remove-Item -LiteralPath $archive -Force }
# Write forward-slash ZIP paths so Windows and Unix extractors agree on folder layout.
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::Open($archive, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    Get-ChildItem -LiteralPath $stage -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($stage.Length).TrimStart([char[]]@('\','/')).Replace('\','/')
        [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $zip, $_.FullName, $relative, [System.IO.Compression.CompressionLevel]::Optimal)
    }
} finally {
    $zip.Dispose()
}
Write-Host "BUILT: $archive"
Write-Host 'v1.1.0 compiled and packaged; verify the versioned build before publishing to GitHub/Forge.'
