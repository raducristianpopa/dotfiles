function node_version -d "Returns the current node version"
  echo (node -v | sed -E "s/v//g")
end