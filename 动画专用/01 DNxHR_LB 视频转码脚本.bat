@echo off

REM 设置文件的后缀名变量
set suffix=_DNx.mov

REM 设置文件路径变量：在文件夹的相同路径建立副本文件夹
set dist=%~dp1%~n1_DNx

REM -profile:v 选择编码类型
REM dnxhr_444   4:4:4 10bit 12bit
REM dnxhr_hqx   4:2:2 10bit 12bit
REM dnxhr_hq    4:2:2 8bit
REM dnxhr_sq    4:2:2 8bit
REM dnxhr_lb    4:2:2 8bit
set profile=dnxhr_lb
set param=-c:v dnxhd -profile:v %profile% -pix_fmt yuv422p -c:a pcm_s16le -ac 2 -ar 48000

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
