local getArch = require "getHostArchitecture"
local getParentFolderName = require "getParentFolderName"
local getDependencies = require "getDependencies"
local detectNvcc = require "detectNvcc"

return {
  getHostArchitecture = getArch.getHostArchitecture,
  getParentFolderName = getParentFolderName.getParentFolderName,
  getDependencies     = getDependencies.getDependencies,
  detectNvcc          = detectNvcc.detectNvcc
}
