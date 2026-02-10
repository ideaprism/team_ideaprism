$baseDir = "d:\00. In-box\test\team_ideaprism\images\kodari_chief"
$files = @("01_salute.png", "02_thumbsup.png", "03_success.png")

foreach ($filename in $files) {
    $path = Join-Path $baseDir $filename
    $dest = Join-Path $baseDir "$($filename).b64.txt"
    if (Test-Path $path) {
        $bytes = [IO.File]::ReadAllBytes($path)
        $b64 = [Convert]::ToBase64String($bytes)
        # Split into lines of 76 chars
        $chunked = $b64 -replace "(.{76})", "`$1`r`n"
        Set-Content -Path $dest -Value $chunked
        Write-Host "Converted $filename to $dest"
    } else {
        Write-Error "File not found: $path"
    }
}
