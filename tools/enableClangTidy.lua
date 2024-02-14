require('vstudio')

local function enableClangTidy(prj)
  premake.w('<EnableClangTidyCodeAnalysis>true</EnableClangTidyCodeAnalysis>')
  premake.w('<RunCodeAnalysis>true</RunCodeAnalysis>')
end

premake.override(premake.vstudio.vc2010.elements, "outputProperties", function(base, prj)
  local calls = base(prj)

  if prj.project.clangTidy then
    table.insertafter(calls, premake.vstudio.vc2010.targetName, enableClangTidy)
  end

  return calls
end)
