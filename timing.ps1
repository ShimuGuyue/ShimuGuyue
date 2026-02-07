# 获取当前绝对路径并拼接脚本路径
$path = (Get-Location).Path
$file = Join-Path $path "rebuild.ps1"

# 定义操作：指定工作目录和执行参数
$action = New-ScheduledTaskAction -Execute 'powershell.exe' `
    -Argument "-ExecutionPolicy Bypass -File `"$file`"" `
    -WorkingDirectory $path

# 定义触发器
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 2)

# 注册任务
Register-ScheduledTask -TaskName "VitePressAutoUpdate" -Action $action -Trigger $trigger -User "System" -RunLevel Highest -Force
# 立即执行一次
Start-ScheduledTask -TaskName "VitePressAutoUpdate"
# 终止定时任务：Unregister-ScheduledTask -TaskName "VitePressAutoUpdate" -Confirm:$false
