function path_exists

  set --local options (CLI_options \
    (format_option --name path --requires-value) \
    (format_option --name file)                  \
    )

  argparse --name path_exists $options -- $argv; or return 1

  if set --query _flag_file
    return (test -fd $_flag_file)
  end

end
