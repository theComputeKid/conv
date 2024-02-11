--* Deduces the architecture of the host system.
local getCmdOutput = require "getCommandOutput"

local function getArchitectureWindows()

  --* Virtual machines use this variable.
  if os.getenv("PROCESSOR_ARCHITEW6432") == "AMD64" then
    return "x86_64"
  end

  local myArch = os.getenv("PROCESSOR_ARCHITECTURE")

  if myArch == "AMD64" then
    return "x86_64"
  end

  --* x86, ARM, ARM64: Same as premake arch values.
  return myArch
end

local function getArchitectureUnix()
  return getCmdOutput.getCommandOutput("uname -p")
end

local function getHostArchitecture()

  if os.host() == "windows" then
    return getArchitectureWindows()
  else
    return getArchitectureUnix()
  end

end

return { getHostArchitecture = getHostArchitecture }
