local myName = prjNamePrefix .. projectTools.getParentFolderName()
local mySrcDir = path.getabsolute(".")
table.insert(srcProjectNames, myName)

project(myName)

  kind "SharedLib"
  location(prjDir .. "/%{prj.name}")
  clangTidy "On"

  defines { prjExportMacro }

  files {
    srcCommonDir .. "/**.cpp",
    mySrcDir .. "/**.cpp"
  }

  vpaths {
    ["Sources/*"] = mySrcDir .. "/**.cpp",
    ["Common/*"] = srcCommonDir .. "/**.cpp",
    ["Headers/*"] = mySrcDir .. "/**.hpp"
  }
