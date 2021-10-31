# cmp-vimwiki-tags

Nvim cmp source for Vimwiki tags. 

## Setup

```lua
require'cmp'.setup {
  sources = {
    { name = 'vimwiki-tags' }
  }
}
```

## Requirements

This is made for personal use, but I thought there might be others who could benefit. It requires opening the Vimwiki directory instead of an individual file. 

I use this shell script to launch Vimwiki. It opens the Vimwiki directory and then immediately opens either the file with the name of the first argument (which will create that file if it does not exist), or the index file in case of no arguments. If you pass more than one argument it will add them as tags to the top of the file.

```bash
function note_fn() {
  if [[ "$1" == "" ]]; then
    cd "$vimwiki_path" && nvim -c "e index.md" .
  elif [[ "$2" == "" ]]; then
    cd "$vimwiki_path" && nvim -c "e $1.md" .
  else
    tags=":"
    for tag in "${@:2}"; do
      tags="$tags$tag:"
    done
    cd "$vimwiki_path" && nvim -c "e $1.md | execute 'normal ggO$tags'" .
  fi
}
alias note=note_fn
```
(Put this in .bashrc or .zshrc, and change the index file name and Vimwiki path to ones that fit your config. Notice the script assumes the .md extension.)
