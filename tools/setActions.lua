--* Lists all available premake actions.
local getNumProcessors = require "getNumProcessors"
local getDependencies = require "getDependencies"
local deleteFolder = require "deleteFolder"

newaction {
  trigger     = "deps",
  description = "Downloads all external project dependencies.",
  
  execute = function ()
    getDependencies.getDependencies(extDir)
  end
}

newaction {
  trigger     = "clean",
  description = "Cleans everything.",
  
  execute = function ()
    print(deleteFolder.deleteFolder(outDir))
  end
}
