# * Install a local copy of premake.

$script:depsDir = Join-Path -Path "out" "tmp" "deps"
$script:premakeDir = Join-Path -Path $depsDir -ChildPath "premake-core"

if (Test-Path $premakeDir) {
  Remove-Item -Recurse -Force -path $premakeDir
}

New-Item -ItemType Directory -Path $depsDir -Force

git clone --depth 1 --branch v5.0.0-beta2 -c advice.detachedHead=false https://github.com/premake/premake-core.git $premakeDir

$script:prevPwd = $PWD;
Set-Location -ErrorAction Stop -LiteralPath $premakeDir

try {
  if ($IsWindows) {
    nmake.exe -nologo -f Bootstrap.mak windows
  }
  elseif ($IsLinux) {
    # * Requires uuid (e.g. sudo apt install uuid-dev)
    make  -f Bootstrap.mak linux
  }
  elseif ($IsMacOS) {
    make  -f Bootstrap.mak macosx
  }
  $prevPwd | Set-Location
}
finally {
  # Restore the previous location.
  $prevPwd | Set-Location
}
