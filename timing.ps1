# 获取路径
$path = (Get-Location).Path
$file = Join-Path $path "rebuild.ps1"

# 定义操作
$action = New-ScheduledTaskAction -Execute 'powershell.exe' `
    -Argument "-ExecutionPolicy Bypass -File `"$file`"" `
    -WorkingDirectory $path

# 定义每天凌晨 4 点的触发器
$startTime = Get-Date -Hour 4 -Minute 0 -Second 0
if ((Get-Date) -gt $startTime) { $startTime = $startTime.AddDays(1) }
$trigger = New-ScheduledTaskTrigger -Daily -At $startTime

# 注册任务
Register-ScheduledTask -TaskName "VitePressAutoUpdate" -Action $action -Trigger $trigger -User "System" -RunLevel Highest -Force

# 删除任务
# Unregister-ScheduledTask -TaskName "VitePressAutoUpdate" -Confirm:$false