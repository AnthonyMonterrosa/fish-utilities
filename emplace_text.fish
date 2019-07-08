function emplace_text

  set --local options (CLI_options \
    (format_option --name file --requires-value) \
  )

  argparse --name emplace_files $options -- $argv; or return 1

  set --local file (canonical_path --path $_flag_file)
  
  set --local file_regex   '^\#[ ]*Emplace[ ]+File[ ]*:[ ]*.*$'
  set --local output_regex '^\#[ ]*Emplace[ ]+Output[ ]*:[ ]*.*$'

  set --local output_text
  for line in (cat $file)

    if string match --regex --quiet $file_regex $line
      set --local file_to_emplace (string match --regex '\.{0,2}/.*$' $line)
      set --append output_text (cat $file_to_emplace)

    else if string match --regex --quiet $output_regex $line
      set --local command (string match --regex ': (.*)$' $line)[2]
      set --append output_text (eval $command)
    
    else
      set --append output_text $line
    
    end

  end

  echo -e (string join '\n' $output_text)

end

emplace_text $argv