function CLI_options

  set --local options
  set --local options $options (fish_opt \
    --short 1                            \
    --long  name                         \
    --long-only                          \
    --multiple-vals                      \
  )
  set --local options $options (fish_opt \
    --short 2                            \
    --long  requires-value               \
    --long-only                          \
    --multiple-vals                      \
  )

  argparse --name CLI_options $options -- $argv; or return 1

  if not test (count $_flag_name) -eq (count $_flag_requires_value)
    echo "Must give equal number of each flag." >&2
    return 1
  end

  set --local short_flags                             \
  a b c d e f g h i j k l m n o p q r s t u v w x y z \
  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \
  0 1 2 3 4 5 6 7 8 9

  set --local option_count     (count $_flag_name)
  set --local short_flag_count (count $short_flags)

  if test $option_count -gt $short_flag_count
    echo "Maximum number of options is $short_flag_count." >&2
    return 1
  end

  set --local iteration 1
  while test $iteration -le $option_count
    
    set --local iteration_options
    
    if test $_flag_requires_value[$iteration] = true
      set iteration_options $iteration_options '--required-val'
    end

    echo (fish_opt                     \
      --short $short_flags[$iteration] \
      --long  $_flag_name[$iteration]  \
      --long-only                      \
      $iteration_options               \
    )

    set iteration (math $iteration + 1)
  end

end