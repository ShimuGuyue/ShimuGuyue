# 切换到脚本目录
Set-Location $PSScriptRoot

# 遇到错误即停止
$ErrorActionPreference = "Stop"

# 调用子脚本
$pullScript = Get-ChildItem -Path "$PSScriptRoot\docs" -Filter "pull.ps1" -Recurse | Select-Object -First 1 -ExpandProperty FullName

if ($pullScript -and (Test-Path $pullScript)) {
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ">>> STARTING SUB-PROJECT UPDATE" -ForegroundColor Magenta
    Write-Host "Found Script: $pullScript" -ForegroundColor Gray
    Write-Host "========================================" -ForegroundColor Magenta

    # 执行子项目脚本
    & $pullScript
}

# 回到脚本目录
Set-Location $PSScriptRoot

# 清理并构建
$distPath = Join-Path $PSScriptRoot "docs\.vitepress\dist"
if (Test-Path $distPath) {
    Remove-Item -Path $distPath -Recurse -Force
}

Write-Host "`n>>> STEP 2: BUILDING MAIN PROJECT" -ForegroundColor Cyan
npm run docs:build

Write-Host "`nSUCCESS: Rebuilt!" -ForegroundColor Green