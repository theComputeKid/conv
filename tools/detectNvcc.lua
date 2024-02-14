local function detectNvcc()
  if os.host() == "linux" then
    result, errorCode = os.outputof("/usr/local/cuda/bin/nvcc --version")
  elseif os.host() == "windows" then
    result, errorCode = os.outputof("nvcc --version")
  else
    errorCode = 1
  end
  return errorCode == 0
end

return { detectNvcc = detectNvcc }
