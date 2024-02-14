if not enableTests then
  return
end

gtestDir = extDir .. "/googletest/googletest"

if not os.isdir(gtestDir) then
  projectTools.getDependencies(extDir)
end

project("googletest")

  kind "StaticLib"
  location(prjDir .. "/%{prj.name}")
  warnings "Off"

  externalincludedirs {
    gtestDir,
    gtestDir .. "/include"
  }

  files {
    gtestDir .. "/include/**.h",
    gtestDir .. "/src/gtest-all.cc",
    gtestDir .. "/src/gtest_main.cc"
  }

  vpaths {
    ["Sources/*"] = gtestDir .. "/src/**.c*",
    ["Headers/*"] = gtestDir .. "/include/**.h*"
  }
