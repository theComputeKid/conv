--* Get the number of processors on the host PC.
local getCmdOutput = require "getCommandOutput"

local function getNumProcessors()

  if os.host() == "windows" then
    return os.getenv("NUMBER_OF_PROCESSORS")
  else
    return getCmdOutput.getCommandOutput("getconf _NPROCESSORS_ONLN");
  end

end

return { getNumProcessors = getNumProcessors }
