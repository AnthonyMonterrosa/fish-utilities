function absolute_path

  # Setup CLI arguments for absolute_path.
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

  argparse --name absolute_path $options -- $argv
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

  # If relative file name is without './' prefix, adds it.
  
  switch $file_name
    case '/*' './*' '../*'
    case '*'
      set file_name "./$file_name"
  end

  # Resolves '..' symbolic links, then '.' symbolic links.

  switch $file_name
    case '*..*'
      set file_name (string replace .. (readlink --canonicalize ..) $file_name)
  end

  switch $file_name
    case '*.*'
      set file_name (string replace . (readlink --canonicalize .) $file_name)
  end

  # Setup CLI arguments for linux-command 'readlink', 
  # which resolves symbolic links.

  set --local readlink_options

  if set --query resolve_symbolic_links
    set readlink_options $readlink_options '--canonicalize'
  end

  set --local output (readlink $readlink_options --no-newline $file_name)

  # Checks if file actually exists. 
  # If it does, write to standard output.

  if test -e $output
    echo $output
  else
    echo "File does not exist." >&2
    return 1
  end

end

absolute_path $argv