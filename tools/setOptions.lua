newoption {
  trigger = "ci",
  description = "Emulates a complete ci build, assuming all build tools are present.",
  category    = "Build Options"
}

newoption {
  trigger = "clangtidy",
  description = "Run ClangTidy as part of MSVC's build project.",
  category    = "Build Options"
}

newoption {
  trigger = "cuda",
  description = "Forcibly build CUDA projects.",
  category    = "Build Options"
}

newoption {
  trigger = "test",
  description = "Build test projects.",
  category    = "Build Options"
}

if _OPTIONS["ci"] or _OPTIONS["clangtidy"] then
  require "enableClangTidy"
end

if _OPTIONS["ci"] or _OPTIONS["test"] then
  enableTests = true
end

premake.api.register {
  name = "clangTidy",
  scope = "project",
  kind = "boolean",
  default = false
}
