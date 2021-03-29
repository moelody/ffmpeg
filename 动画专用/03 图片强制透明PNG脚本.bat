@echo off

REM 设置文件的后缀名变量
set suffix=.png

REM 设置文件路径变量：在文件夹的相同路径建立副本文件夹
set dist=%~dp1%~n1_Alpha

REM aa=0.10  10%不透明度（可以更改数字）
set aa=0.10
set param=-vf format=yuva444p,colorchannelmixer=aa=%aa%

REM 对文件和文件夹进行批处理
if exist "%~1\" (

REM 建立副本文件夹
md "%dist%"

for %%i in ("%~1\*") do (
  ffmpeg -i "%%i" %param% "%dist%\%%~ni%suffix%"
)

) else (

  ffmpeg -i "%~1" %param% "%~dpn1%suffix%"

)
