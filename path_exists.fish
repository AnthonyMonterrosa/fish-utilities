function path_exists

  set --local options (fish CLI-options.fish               \
    (fish format-option.fish --name path --requires-value) \
    (fish format-option.fish --name file)                  \
    )

  argparse --name path_exists $options -- $argv; or return 1

  if set --query _flag_file
    return (test -f $_flag_path)
  end

end

path_exists $argv

