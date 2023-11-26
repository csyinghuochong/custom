@echo off
xcopy E:\gitcustom\trunk_custom\ServerHotfix H:\GitWeiJing\Server\Hotfix\Custom /s /e
xcopy E:\gitcustom\trunk_custom\ServerConsole H:\GitWeiJing\Server\Hotfix\Module\Console\Custom /s /e
echo "复制完成！"
pause


dotnet publish  Client-Server.sln  --output .\Release\BinBeta
pause