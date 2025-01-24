$Env:HF_HOME = "huggingface"
$Env:PYTHONUTF8 = "1"

if (Test-Path -Path "venv\Scripts\activate") {
    Write-Host -ForegroundColor green "Activating virtual environment..."
    .\venv\Scripts\activate
}
elseif (Test-Path -Path "python\python.exe") {
    Write-Host -ForegroundColor green "Using python from python folder..."
    $py_path = (Get-Item "python").FullName
    $env:PATH = "$py_path;$env:PATH"
}
else {
    Write-Host -ForegroundColor Blue "No virtual environment found, using system python..."
}

# 指定源文件夹和目标路径
$sourceFolder = "feishu"
$targetFolder = "scripts\stable\feishu"

# 删除目标文件夹（如果存在）
if (Test-Path $targetFolder) {
    Remove-Item -Recurse -Force -Path $targetFolder
    Write-Host "目标文件夹已删除: $targetFolder"
}

# 复制源文件夹到目标路径
Copy-Item -Recurse -Force -Path $sourceFolder -Destination $targetFolder
Write-Host "文件夹已复制到: $targetFolder"

python gui.py --host 0.0.0.0