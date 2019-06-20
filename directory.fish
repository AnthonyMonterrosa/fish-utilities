function directory

  # Setup CLI arguments for directory.
  # file-name: a relative or absolute path to a file.
  # resolve-symbolic-links: if the flag is given, symbolic links in the absolute path are resolved to the file's true directory/name.

  set --local options (fish CLI-options.fish                    \
    (fish format-option.fish --name file-name --requires-value) \
    )

  argparse --name directory $options -- $argv; or return 1

  # file_name is a mandatory argument.

  if not set --query _flag_file_name
    echo "File name not given (--file-name)." >&2
    return 1
  end

  # Write directory of file to standard output.

  echo (dirname (fish canonical-path.fish --path $_flag_file_name))
end

directory $argv