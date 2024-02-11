--* Get the parent folder name.
local function getParentFolderName()
  return path.getbasename(path.getabsolute("."))
end

return { getParentFolderName = getParentFolderName }
