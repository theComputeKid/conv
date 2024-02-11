local getArch = require "getHostArchitecture"
local getParentFolderName = require "getParentFolderName"
local getDependencies = require "getDependencies"

require "setActions"

return {
  getHostArchitecture = getArch.getHostArchitecture,
  getParentFolderName = getParentFolderName.getParentFolderName,
  getDependencies     = getDependencies.getDependencies
}
