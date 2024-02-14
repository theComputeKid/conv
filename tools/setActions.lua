--* Lists all available premake actions.
local getNumProcessors = require "getNumProcessors"
local getDependencies = require "getDependencies"
local deleteFolder = require "deleteFolder"
local getExportedSymbols = require "getExportedSymbols"

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

if os.host() == "windows" then
  newaction {
    trigger     = "launch",
    description = "Launch an already-created Visual Studio .",

    execute = function ()
      os.chdir(prjDir)
      os.execute("devenv " .. prjName .. ".sln")
    end
  }
end

newaction {
  trigger     = "debug",
  description = "Build in debug mode.",

  execute = function ()
    os.chdir(prjDir)
    if os.host() == "windows" then
      os.execute("msbuild --nologo -p:Configuration=debug -m -v:Normal")
    else
      os.execute("make config=debug -j" .. getNumProcessors.getNumProcessors())
    end
  end
}

newaction {
  trigger     = "release",
  description = "Build in release mode.",

  execute = function ()
    os.chdir(prjDir)
    if os.host() == "windows" then
      os.execute("msbuild --nologo -p:Configuration=release -m -v:Normal")
    else
      os.execute("make config=release -j" .. getNumProcessors.getNumProcessors())
    end
  end
}

newaction {
  trigger     = "symbols",
  description = "Lists exported symbols in the shared library.",

  execute = function ()
    print(getExportedSymbols.getExportedSymbols(binDir, prjNamePrefix))
  end
}

newaction {
  trigger     = "all",
  description = "Builds a project with everything enabled.",

  execute = function ()
    if os.host() == "windows" then
      os.execute(_PREMAKE_COMMAND .. " vs2022 --ci")
    else
      os.execute(_PREMAKE_COMMAND .. " gmake2 --ci")
    end
    os.execute(_PREMAKE_COMMAND .. " debug && " .. _PREMAKE_COMMAND .. " release")
  end
}
