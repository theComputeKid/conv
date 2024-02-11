projectTools = require "tools/projectTools"

--* Get project name from parent folder.
prjName = projectTools.getParentFolderName()

--* important folder paths
rootDir = path.getabsolute(".")

outDir = rootDir .. "/out"
binDir = outDir .. "/bin"
tmpDir = outDir .. "/tmp"
prjDir = outDir .. "/projects"
srcDir = rootDir .. "/src"
incDir = rootDir .. "/include"
extDir = tmpDir .. "/deps"
testDir = rootDir .. "/test"

--* Early exit if project generation not required.
if _ACTION == nil or _ACTION == "clean" then
  return
end

if not os.isdir(extDir .. "/premake5-cuda") then
  projectTools.getDependencies(extDir)
end

require(extDir .. "/premake5-cuda")
