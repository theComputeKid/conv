if not enableTests then
  return
end

nanobenchDir = extDir .. "/nanobench"

if not os.isdir(nanobenchDir) then
  projectTools.getDependencies(extDir)
end

project("nanobench")

  kind "StaticLib"
  location(prjDir .. "/%{prj.name}")
  warnings "Off"

  externalincludedirs {
    nanobenchDir .. "/src/include"
  }

  files {
    "main.cpp",
    nanobenchDir .. "/src/include/nanobench.h"
  }

  forceincludes  { "nanobench.h" }
  defines { "ANKERL_NANOBENCH_IMPLEMENT" }

  vpaths {
    ["Sources/*"] = "**.cpp",
    ["Headers/*"] = nanobenchDir .. "/src/include/**.h"
  }
