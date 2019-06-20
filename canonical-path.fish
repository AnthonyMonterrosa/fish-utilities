function canonical_path --description "Resolves all symbolic links in given path."

  set --local options (fish CLI-options.fish               \
    (fish format-option.fish --name path --requires-value) \
    )

  argparse --name canonical_path $options -- $argv; or return 1
  
  set --local path (realpath $_flag_path)

  if fish path-exists.fish --file --path $path
    echo (realpath $path)
  else
    echo "Path does not exist." >&2
    return 1
  end

end
canonical_path $argv