local myName = selectedBackend .. "-" .. projectTools.getParentFolderName()
local mySrcDir = path.getabsolute(".")

project(myName)

  kind "ConsoleApp"
  location(prjDir .. "/%{prj.name}")

  externalincludedirs {
    gtestDir,
    gtestDir .. "/include"
  }

  files { mySrcDir .. "/**.cpp" }

  vpaths {
    ["Sources/*"] = mySrcDir .. "/**.c*",
    ["Headers/*"] = mySrcDir .. "/**.h*"
  }

  links {
    "googletest",
    selectedBackend
   }
