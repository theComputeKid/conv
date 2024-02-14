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

  --* Delete .git so it doesn't interfere in our version control.
  delOut = deleteFolder.deleteFolder(folderName .. "/.git")
  print(delOut)
end

local function getDependencies(depDir)
  myDir = os.getcwd()
  os.mkdir(depDir)
  os.chdir(depDir)
  getDependency("https://github.com/google/googletest.git", "v1.14.0")
  getDependency("https://github.com/martinus/nanobench.git", "v4.3.11")
  getDependency("https://github.com/theComputeKid/premake5-cuda.git", "main")
  os.chdir(myDir)
end

return { getDependencies = getDependencies }
