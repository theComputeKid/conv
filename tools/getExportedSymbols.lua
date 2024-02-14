--* Gets the exported symbols from shared libraries.

local function getSymbols(lib)

  if os.host() == "windows" then
    cmd = "dumpbin /nologo /EXPORTS "
  else
    cmd = "nm -D --defined-only "
  end

  if os.host() ~= "windows" then
    print("-----")
  end
  print(lib .. ":")
  os.execute(cmd .. lib)
end

local function getExportedSymbols(binDir, prjName)

  if os.host() == "windows" then
    ext = "lib"
  else
    ext = "so"
  end

  p = binDir .. "/" .. prjName .. "**." .. ext
  matches = os.matchfiles(p)
  table.foreachi(matches, getSymbols)
end

return { getExportedSymbols = getExportedSymbols }
