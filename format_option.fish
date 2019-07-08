function format_option

  set --local options
  set --local options $options (fish_opt \
    --short 1                            \
    --long  name                         \
    --long-only                          \
    --required-val                       \
    )
  set --local options $options (fish_opt \
    --short 2                            \
    --long  requires-value               \
    --long-only                          \
    )

  argparse --name format_option $options -- $argv; or return 1

  echo "--name"
  echo $_flag_name
  
  echo "--requires-value"
  set --query _flag_requires_value; and echo true; or echo false

end