# 切换到脚本目录
Set-Location $PSScriptRoot

# 遇到错误即停止
$ErrorActionPreference = "Stop"

# 调用所有 pull.ps1 子脚本
$pullScripts = Get-ChildItem -Path "$PSScriptRoot\docs" -Filter "pull.ps1" -Recurse

if ($pullScripts) {
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ">>> STARTING SUB-PROJECT UPDATES" -ForegroundColor Magenta
    Write-Host "Found $($pullScripts.Count) script(s)" -ForegroundColor Gray
    Write-Host "========================================" -ForegroundColor Magenta

    foreach ($script in $pullScripts) {
        $scriptPath = $script.FullName
        $scriptDir = $script.DirectoryName

        Write-Host "`n--> Running: $scriptPath" -ForegroundColor Cyan

        Push-Location $scriptDir
        try {
            & $scriptPath
        }
        finally {
            Pop-Location
        }
    }
}

# 回到脚本目录
Set-Location $PSScriptRoot

# 清理并构建
$distPath = Join-Path $PSScriptRoot "docs\.vitepress\dist"
if (Test-Path $distPath) {
    Write-Host "`n>>> CLEANING OLD BUILD" -ForegroundColor Gray
    Remove-Item -Path $distPath -Recurse -Force
}

Write-Host "`n>>> STEP 2: BUILDING MAIN PROJECT" -ForegroundColor Cyan
npm run docs:build

Write-Host "`nSUCCESS Rebuilt!" -ForegroundColor Green
