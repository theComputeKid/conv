local myName = prjNamePrefix .. projectTools.getParentFolderName()
local mySrcDir = path.getabsolute(".")
table.insert(srcProjectNames, myName)

project(myName)

  kind "SharedLib"
  location(prjDir .. "/%{prj.name}")
  clangTidy "On"

  defines { prjExportMacro }
  files { mySrcDir .. "/**" }

  vpaths {
    ["Sources/*"] = mySrcDir .. "/**.c*",
    ["Headers/*"] = mySrcDir .. "/**.h*"
  }
