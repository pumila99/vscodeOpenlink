# build.ps1 - Build & vsix package generation script
# Usage: Run .\build.ps1 in PowerShell

$ErrorActionPreference = "Stop"

Write-Host "=== open-with-default-app Build Script ===" -ForegroundColor Cyan

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
Write-Host "`n[1/3] npm install ..." -ForegroundColor Cyan
npm install
if ($LASTEXITCODE -ne 0) { Write-Host "[ERROR] npm install failed" -ForegroundColor Red; exit 1 }

# Compile TypeScript
Write-Host "`n[2/3] TypeScript compile ..." -ForegroundColor Cyan
npm run compile
if ($LASTEXITCODE -ne 0) { Write-Host "[ERROR] compile failed" -ForegroundColor Red; exit 1 }

# Generate vsix package
Write-Host "`n[3/3] Generate vsix package ..." -ForegroundColor Cyan
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