@echo off

REM 设置文件的后缀名变量
set suffix=_ProRes.mov

REM 设置文件路径变量：在文件夹的相同路径建立副本文件夹
set dist=%~dp1%~n1_ProRes

REM -profile:v 选择编码类型
REM <5> ProRes 4444 XQ 4:4:4 10bit 12bit 16bit
REM <4> ProRes 4444    4:4:4 10bit 12bit 16bit
REM <3> ProRes HQ      4:2:2 10bit 12bit 16bit
REM <2> ProRes         4:2:2 10bit 12bit 16bit
REM <1> ProRes LT      4:2:2 10bit 12bit 16bit
REM <0> ProRes Proxy   4:2:2 10bit 12bit 16bit
set profile=0
set param=-c:v prores_ks -profile:v %profile% -pix_fmt yuv422p10le -bits_per_mb 8000 -c:a pcm_s16le -ac 2 -ar 48000

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
