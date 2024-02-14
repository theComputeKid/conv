
--* important global folder paths.
rootDir = path.getabsolute(".")

outDir = rootDir .. "/out"
binDir = outDir .. "/bin"
tmpDir = outDir .. "/tmp"
prjDir = outDir .. "/projects"
srcDir = rootDir .. "/src"
incDir = rootDir .. "/include"
extDir = tmpDir .. "/deps"
testDir = rootDir .. "/test"
benchDir = rootDir .. "/bench"
toolsDir = rootDir .. "/tools"
exampleDir = rootDir .. "/example"
srcCommonDir = srcDir .. "/common"

projectTools = require(toolsDir .. "/projectTools")

--* Project name prefixes/suffixes.
prjName = projectTools.getParentFolderName()
prjNamePrefix = prjName .. "-"

require(toolsDir .. "/setOptions")
require(toolsDir .. "/setActions")

--* Early exit if project generation not required.
if _ACTION == nil or _ACTION == "clean" or _ACTION == "deps" or _ACTION == "launch" then
  return
end

--* Other global variables.
prjExportMacro = "CONV_EXPORT"
prjDebugMacro = "CONV_DEBUG"
prjVersionMacro = {
  "CONV_VERSION_MAJOR=0",
  "CONV_VERSION_MINOR=0",
  "CONV_VERSION_PATCH=1",
}

--* container for all projects
workspace(prjName)

  language "C++"
  cppdialect "C++latest"
  cdialect "C17"
  architecture(projectTools.getHostArchitecture())

  --* output locations
  location(prjDir)
  objdir(tmpDir .. "/%{prj.name}/%{cfg.buildcfg}")
  targetdir(binDir .. "/%{cfg.buildcfg}")

  includedirs { incDir }
  files { incDir .. "/**" }
  vpaths { ["Interface/*"] = incDir .. "/**" }

  configurations { "debug", "release" }

  defines { prjVersionMacro }
  conformancemode("On")

  --* common compilation and linkage flags
  warnings "Extra"
  externalwarnings "Off"
  externalanglebrackets "On"
  visibility "Hidden"

  flags {
    "FatalWarnings",
    "RelativeLinks",
    "MultiProcessorCompile"
  }

  filter "configurations:release"
    symbols "Off"
    optimize "Full"
    runtime "Release"

  filter "configurations:debug"
    defines {prjDebugMacro}
    symbols "On"
    optimize "Off"
    runtime "Debug"
  filter {}

-- ?-------------------- Load Projects ----------------------

group "deps"
  dofile(toolsDir .. "/deps/premake5.lua")

function loadSourceProjectFile(folderName)
  print("Loading: " .. folderName)
  dofileopt(folderName .. "/premake5.lua")
end

srcProjectNames = {}
group "src"
  local srcProjects = os.matchdirs(srcDir .. "/*")
  table.foreachi(srcProjects, loadSourceProjectFile)

function loadTestProjectFile(projectName)
  selectedBackend = projectName
  dofile(exampleDir .. "/premake5.lua")
  dofile(testDir .. "/premake5.lua")
  dofile(benchDir .. "/premake5.lua")
end

if enableTests then
  group "test"
    table.foreachi(srcProjectNames, loadTestProjectFile)
    workspace(prjName)
      startproject(srcProjectNames[1] .. "-test")
      print(srcProjectNames[1] .. "-test")
end
