$signer = "securityteam@opcfoundation.org"


Get-ChildItem -Filter *.json | ForEach-Object {
    $jsonFile = $_.Name
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($jsonFile)
    $ascFile = "$baseName.json.asc"
    $shaFile = "$baseName.json.sha512"

    # Delete existing output files
    if (Test-Path $ascFile) { Remove-Item $ascFile -Force }
    if (Test-Path $shaFile) { Remove-Item $shaFile -Force }

    Write-Host "Signing $jsonFile" -ForegroundColor Green
    & gpg --local-user $signer --digest-algo SHA512 --armor --detach-sign --output $ascFile $jsonFile

    Write-Host "Verifying Signature for $jsonFile" -ForegroundColor Green
    & gpg --verify $ascFile $jsonFile

    Write-Host "Generating SHA512 hash for $jsonFile" -ForegroundColor Green
    # CSAF Requirement 18 expects sha512sum format: the lowercase hex hash,
    # two spaces, then the file name. Do not use "certutil -hashfile" here --
    # it emits a UTF-16 file with a "SHA512 hash of <name>:" header line that
    # CSAF tools cannot parse.
    $hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA512).Hash.ToLowerInvariant()
    $shaPath = Join-Path $_.DirectoryName $shaFile
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($shaPath, "$hash  $jsonFile`n", $utf8NoBom)
    & type $shaFile
}