function directory

  # Setup CLI arguments for directory.
  # file-name: a relative or absolute path to a file.
  # resolve-symbolic-links: if the flag is given, symbolic links in the absolute path are resolved to the file's true directory/name.

  set --local options
  set --local options $options (fish_opt \
      --short 0                          \
      --long  file-name                  \
      --long-only                        \
      --required-val                     \
    )
  set --local options $options (fish_opt \
      --short 1                          \
      --long  resolve-symbolic-links     \
      --long-only                        \
    )

  argparse --name directory $options -- $argv
  or return

  set --local file_name $_flag_file_name
  set --erase            _flag_file_name

  set --local resolve_symbolic_links $_flag_resolve_symbolic_links
  set --erase                         _flag_resolve_symbolic_links

  # file_name is a mandatory argument.

  if not set --query file_name
    echo "File name not given (--file-name)." >&2
    return 1
  end

  # Setup flags for absolute_path.

  set --local absolute_path_options

  if set --query resolve_symbolic_links
    set absolute_path_options $absolute_path_options '--resolve-symbolic-links'
  end

  # Write directory of file to standard output.

  echo (dirname (fish absolute_path.fish $absolute_path_options --file-name $file_name))
end

directory $argv