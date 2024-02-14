local myName = selectedBackend .. "-" .. projectTools.getParentFolderName()
local mySrcDir = path.getabsolute(".")

project(myName)

  kind "ConsoleApp"
  language "C"

  location(prjDir .. "/%{prj.name}")

  files { mySrcDir .. "/**.c*" }

  vpaths {
    ["Sources/*"] = mySrcDir .. "/**.c*",
    ["Headers/*"] = mySrcDir .. "/**.h*"
  }

  links {
    selectedBackend
   }
