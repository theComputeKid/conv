--* Download project dependencies.
local getCommandOutput = require "getCommandOutput"
local deleteFolder = require "deleteFolder"

local function getDependency(repo, branch)

  cmd = "git clone --depth 1 --branch " .. branch .. " -c advice.detachedHead=false " .. repo
  folderName = path.getbasename(repo)
  
  --* Delete pre-existing repo.
  delOut = deleteFolder.deleteFolder(folderName)
  print(delOut)

  --* Fresh clone.
  out = getCommandOutput.getCommandOutput(cmd)
end

local function getDependencies(depDir)
  os.mkdir(depDir)
  os.chdir(depDir)
  getDependency("https://github.com/google/googletest.git", "v1.14.0")
  getDependency("https://github.com/google/benchmark.git", "v1.8.3")
  getDependency("https://github.com/theComputeKid/premake5-cuda.git", "main")
end

return { getDependencies = getDependencies }
