# build.ps1 - Build & vsix package generation script
# Usage: Run .\build.ps1 in PowerShell

$ErrorActionPreference = "Stop"

Write-Host "=== open-with-default-app Build Script ===" -ForegroundColor Cyan

# ★ Increment version in package.json
Write-Host "`n[0/4] Updating version ..." -ForegroundColor Cyan
$packageJsonPath = Join-Path $PSScriptRoot "package.json"
$packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

# Parse version (e.g., "0.1.10" -> @("0", "1", "10"))
$versionParts = $packageJson.version -split '\.'
$patch = [int]$versionParts[2]
$patch++
$newVersion = "$($versionParts[0]).$($versionParts[1]).$patch"
$packageJson.version = $newVersion

# Write back to file
$packageJson | ConvertTo-Json -Depth 10 | Set-Content $packageJsonPath
Write-Host "  Version updated: $($packageJson.version)" -ForegroundColor Green

# Check Node.js / npm
try {
    $nodeVersion = node --version
    $npmVersion  = npm --version
    Write-Host "Node.js: $nodeVersion" -ForegroundColor Green
    Write-Host "npm    : $npmVersion"  -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Node.js not found." -ForegroundColor Red
    Write-Host "  Please install from https://nodejs.org" -ForegroundColor Yellow
    exit 1
}

# Install dependencies
Write-Host "`n[1/4] npm install ..." -ForegroundColor Cyan
npm install
if ($LASTEXITCODE -ne 0) { Write-Host "[ERROR] npm install failed" -ForegroundColor Red; exit 1 }

# Compile TypeScript
Write-Host "`n[2/4] TypeScript compile ..." -ForegroundColor Cyan
npm run compile
if ($LASTEXITCODE -ne 0) { Write-Host "[ERROR] compile failed" -ForegroundColor Red; exit 1 }

# Generate vsix package
Write-Host "`n[3/4] Generate vsix package ..." -ForegroundColor Cyan
npm run package
if ($LASTEXITCODE -ne 0) { Write-Host "[ERROR] vsce package failed" -ForegroundColor Red; exit 1 }

# Show generated vsix files
$vsixFiles = Get-ChildItem -Filter "*.vsix" | Sort-Object LastWriteTime -Descending
if ($vsixFiles.Count -gt 0) {
    Write-Host "`n=== Build Complete ===" -ForegroundColor Green
    foreach ($f in $vsixFiles) {
        Write-Host "  $($f.FullName)" -ForegroundColor White
    }
    Write-Host "`nHow to install:" -ForegroundColor Cyan
    Write-Host "  VS Code: Ctrl+Shift+P -> 'Extensions: Install from VSIX...'" -ForegroundColor White
    Write-Host "  or: code --install-extension $($vsixFiles[0].Name)" -ForegroundColor White
} else {
    Write-Host "[WARN] No vsix file found" -ForegroundColor Yellow
}