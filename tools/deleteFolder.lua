local getCommandOutput = require "getCommandOutput"

local function deleteFolder(folderName)
  if os.isdir(folderName) then
    if os.target() == "windows" then
      p = path.translate(folderName)
      delOut = getCommandOutput.getCommandOutput("rmdir /s /q " .. p)
    else
      delOut = getCommandOutput.getCommandOutput("rm -rf " .. folderName)
    end
  else
    delOut = "Nothing to delete."
  end
  return delOut
end

return { deleteFolder = deleteFolder }
