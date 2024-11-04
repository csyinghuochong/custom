@echo off
REM 设置要清空的文件夹路径
set "FOLDER_PATH=H:\GitWeiJing\Release\DLCBeta\MJ\Android"
 
REM 移除文件夹内的所有文件
del /Q "%FOLDER_PATH%\*"
 
REM 移除所有子文件夹
for /d %%p in ("%FOLDER_PATH%\*") do @rd /s /q "%%p"
 
echo 文件夹已清空: %FOLDER_PATH%

set source_folder=H:\GitMengJing\Unity\Bundles\Android\DefaultPackage\2024-11-04-1079
set destination_folder=H:\GitWeiJing\Release\DLCBeta\MJ\Android
 
:: 确保目标文件夹存在
if not exist "%destination_folder%" mkdir "%destination_folder%"
 
:: 移动文件夹内容
move "%source_folder%\*" "%destination_folder%"
 
:: 如果需要移动子文件夹，取消下面这行的注释
:: move "%source_folder%\*.*" "%destination_folder%" /s /e
 
:: 如果源文件夹为空，那么删除源文件夹
if not exist "%source_folder%\*" rmdir "%source_folder%"

pause