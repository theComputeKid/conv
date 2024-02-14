--* Cuda project, requires CUDA on the system.
if not _OPTIONS["cuda"] and not projectTools.detectNvcc() then
  return
end

local premakeCudaPath = extDir .. "/premake5-cuda"

if not os.isdir(premakeCudaPath) then
  projectTools.getDependencies(extDir)
end

require(premakeCudaPath)

local myName = prjNamePrefix .. projectTools.getParentFolderName()
local mySrcDir = path.getabsolute(".")
table.insert(srcProjectNames, myName)

local cudaBaseOptions = {
  "-std=c++20",
  "-arch=native",
  "-t0",
  "-Werror all-warnings"
}

local cudaLinkOptions = {
  "-arch=native"
}

if os.target() == "windows" then
  cudaBaseOptions = table.join(cudaBaseOptions, {
    --* warning C4505: '__cudaUnregisterBinaryUtil': unreferenced function with internal linkage has been removed
    --* warning C4005: '_Compiler_barrier': macro redefinition
    "-Xcompiler=-wd4505,-wd4005"
  })
  cudaLinkOptions = table.join(cudaLinkOptions, {
    "-arch=native",
    --* warning C4100: 'prelinked_fatbinc': unreferenced formal parameter
    "-Xcompiler=-wd4100"
  })
end

local cudaReleaseOptions = table.join(cudaBaseOptions, {
  "-extra-device-vectorization",
  "-res-usage"
})

project(myName)

  kind "SharedLib"
  location(prjDir .. "/%{prj.name}")

  cudaRelocatableCode "On"

  forceincludes  { "cuda_runtime.h" }

  defines {
    prjExportMacro
  }

  files {
    mySrcDir .. "/**.cpp"
  }

  vpaths {
    ["Sources/*"] = mySrcDir .. "/**.cpp",
    ["Headers/*"] = mySrcDir .. "/**.hpp"
  }

  cudaKeep "On"
  buildcustomizations {
    "BuildCustomizations/CUDA 12.3"
  }

  if os.target() == "windows" then
    cudaFiles { mySrcDir .. "/**.cu" }
  else
    toolset "nvcc"
    rules {"cu"}
    files { mySrcDir .. "/**.cu" }
  end

  filter "configurations:release"
    cudaCompilerOptions(cudaReleaseOptions)
    cudaFastMath "On"
    cudaGenLineInfo "On"
  filter {}

  filter "configurations:debug"
    cudaCompilerOptions(cudaBaseOptions)
  filter {}

  cudaLinkerOptions(cudaLinkOptions)
