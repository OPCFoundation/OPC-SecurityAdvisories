<#
.SYNOPSIS
    Rebuilds the CSAF directory-based distribution listings.

.DESCRIPTION
    Writes index.txt (CSAF Requirement 12) and changes.csv (CSAF Requirement 13)
    into the CSAF distribution directory. Consumers such as csaf_downloader read
    changes.csv to discover which advisories exist, so these files must be
    regenerated whenever an advisory is added, changed or removed -- otherwise the
    new advisory is silently invisible to every consumer.

    Only TLP:WHITE documents are listed, since this directory is the public
    distribution. Drafts and anything not labelled TLP:WHITE are reported and
    skipped.

    Paths are written relative to the distribution directory with forward
    slashes. Both files are written as UTF-8 without a BOM using LF line endings:
    changes.csv is parsed as CSV by consumers, and a BOM would corrupt the first
    field.

.PARAMETER CsafDir
    The CSAF distribution directory. Defaults to the "csaf" directory next to
    this script's parent, i.e. the repository's csaf folder.

.EXAMPLE
    .\rebuild-index.ps1
    .\rebuild-index.ps1 -CsafDir D:\Work\OPC\OPC-SecurityAdvisories\csaf
#>
param (
    [string]$CsafDir = (Join-Path (Split-Path -Parent $PSScriptRoot) 'csaf')
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $CsafDir)) {
    Write-Host "CSAF directory not found: $CsafDir" -ForegroundColor Red
    exit 1
}

$root = (Resolve-Path $CsafDir).Path
Write-Host "Scanning $root" -ForegroundColor Cyan

$docs = @()

foreach ($file in Get-ChildItem -Path $root -Recurse -Filter *.json -File) {

    $rel = $file.FullName.Substring($root.Length).TrimStart('\', '/').Replace('\', '/')

    # Skip editor/tool directories such as .vs
    if ($rel -match '(^|/)\.') { continue }

    # provider-metadata.json describes the provider; it is not an advisory
    if ($rel -eq 'provider-metadata.json') { continue }

    try {
        $json = Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json
    }
    catch {
        Write-Host "  skipped, not valid JSON: $rel" -ForegroundColor DarkGray
        continue
    }

    # Identify CSAF documents rather than trusting the file extension
    if (-not $json.document -or -not $json.document.csaf_version -or -not $json.document.tracking.id) {
        Write-Host "  skipped, not a CSAF document: $rel" -ForegroundColor DarkGray
        continue
    }

    $trackingId = $json.document.tracking.id

    $tlp = $null
    if ($json.document.distribution -and $json.document.distribution.tlp) {
        $tlp = $json.document.distribution.tlp.label
    }
    if ($tlp -ne 'WHITE') {
        $shown = if ($tlp) { "TLP:$tlp" } else { 'no TLP label' }
        Write-Host "  EXCLUDED, $shown so not public: $rel" -ForegroundColor Yellow
        continue
    }

    # CSAF Requirement 2: the file name is the lower-cased tracking ID. Any run of
    # characters outside [+\-a-z0-9] collapses to a single underscore.
    $expected = ($trackingId.ToLowerInvariant() -replace '[^+\-a-z0-9]+', '_') + '.json'
    if ($file.Name -ne $expected) {
        Write-Host "  WARNING file name does not match tracking ID '$trackingId': $rel (expected $expected)" -ForegroundColor Red
    }

    if ($json.document.tracking.status -ne 'final') {
        Write-Host "  NOTE status is '$($json.document.tracking.status)': $rel" -ForegroundColor Yellow
    }

    $releaseDate = $json.document.tracking.current_release_date

    $docs += [pscustomobject]@{
        Path    = $rel
        Date    = $releaseDate
        SortKey = [datetimeoffset]::Parse($releaseDate)
    }
}

if ($docs.Count -eq 0) {
    # Refuse to overwrite good listings with empty ones.
    Write-Host "No TLP:WHITE CSAF documents found; leaving index.txt and changes.csv untouched." -ForegroundColor Red
    exit 1
}

$indexPath = Join-Path $root 'index.txt'
$changesPath = Join-Path $root 'changes.csv'

# The two listings must be updated together: a fresh index.txt beside a stale
# changes.csv would misrepresent the distribution. Confirm both are writable
# before touching either. A .csv left open in Excel holds an exclusive lock.
foreach ($target in @($indexPath, $changesPath)) {
    if (-not (Test-Path -LiteralPath $target)) { continue }
    try {
        $stream = [System.IO.File]::Open($target, 'Open', 'Write', 'None')
        $stream.Close()
    }
    catch {
        Write-Host "Cannot write $target - it is locked by another process." -ForegroundColor Red
        Write-Host "Close it and re-run; a .csv open in Excel holds an exclusive lock. Nothing was changed." -ForegroundColor Red
        exit 1
    }
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# index.txt: one relative path per line, sorted by path.
$indexLines = $docs | Sort-Object Path | ForEach-Object { $_.Path }

# changes.csv: "path","current_release_date", newest first, no header row.
# Consumers do not skip a header, so one would be parsed as data.
$changesLines = $docs |
    Sort-Object -Property @{ Expression = 'SortKey'; Descending = $true }, @{ Expression = 'Path'; Descending = $true } |
    ForEach-Object { '"{0}","{1}"' -f $_.Path, $_.Date }

[System.IO.File]::WriteAllText($indexPath, (($indexLines -join "`n") + "`n"), $utf8NoBom)
[System.IO.File]::WriteAllText($changesPath, (($changesLines -join "`n") + "`n"), $utf8NoBom)

Write-Host "Wrote $indexPath ($($docs.Count) entries)" -ForegroundColor Green
Write-Host "Wrote $changesPath ($($docs.Count) entries)" -ForegroundColor Green
