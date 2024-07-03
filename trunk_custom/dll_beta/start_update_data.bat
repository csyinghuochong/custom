::先备份数据库     要移除的区—>新区     在修改物理区
cd publish
dotnet Server.dll --AppType=UpdateDB --Console=1 --StartConfig=StartConfig/Beta --Title=MergeZone --Process 1
pause