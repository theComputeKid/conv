$script:depsDir = "out\tmp\deps"
$script:premakeDir = $depsDir + "\premake-core"

if (Test-Path $premakeDir) {
  Remove-Item -Recurse -Force -path $premakeDir
}

New-Item -ItemType Directory -Path $depsDir -Force

git clone --depth 1 --branch v5.0.0-beta2 -c advice.detachedHead=false https://github.com/premake/premake-core.git $premakeDir

$script:prevPwd = $PWD;
Set-Location -ErrorAction Stop -LiteralPath $premakeDir

try {
  nmake.exe -nologo -f Bootstrap.mak windows
  $prevPwd | Set-Location
}
finally {
  # Restore the previous location.
  $prevPwd | Set-Location
}
