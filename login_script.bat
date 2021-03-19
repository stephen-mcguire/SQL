@echo off
%windir%\System32\runas.exe /netonly /user:pstccad\sbmcguire "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe -S web-students.pstcc.edu"
