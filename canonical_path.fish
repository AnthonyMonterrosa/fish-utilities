function canonical_path --description "Resolves all symbolic links in given path."

  set --local options (CLI_options \
    (format_option --name path --requires-value) \
    )

  argparse --name canonical_path $options -- $argv; or return 1
  
  set --local path (realpath $_flag_path)

  if path_exists --file --path $path
    echo (realpath $path)
  else
    echo "Path does not exist." >&2
    return 1
  end

end