$script:premakePath = "out\tmp\deps\premake-core\bin\release\premake5.exe"
Start-Process -NoNewWindow -FilePath $premakePath -ArgumentList "$args" -Wait
