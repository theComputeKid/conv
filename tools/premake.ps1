# * Wrapper to act as the premake executable built by this project locally.
$script:premakePath = Join-Path -Path "out" "tmp" "deps" "premake-core" "bin" "release" "premake5"
. $premakePath $args
