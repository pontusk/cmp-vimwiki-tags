# cmp-vimwiki-tags

Nvim cmp source for Vimwiki tags. 

## Setup

```lua
require'cmp'.setup {
  sources = {
    { name = 'emoji' }
  }
}
```

## Requirements

This is made for personal use, but I thought there might be others who could benefit. It requires opening the Vimwiki directory instead of an individual file. 

I use this shell script to launch vim wiki. It opens the vimwiki directory and then immediately opens either the file with the name of the argument, or the index file. If you pass more than one argument it will add them as tags to the top of the file.

```bash
function note_fn() {
  if [[ "$1" == "" ]]; then
    cd "$vimwiki_path" && vim -c "e index.md" .
  elif [[ "$2" == "" ]]; then
    cd "$vimwiki_path" && vim -c "e $1.md" .
  else
    tags=":"
    for tag in "${@:2}"; do
      tags="$tags$tag:"
    done
    cd "$vimwiki_path" && vim -c "e $1.md | execute 'normal ggO$tags'" .
  fi
}
alias note=note_fn
```
(put this in .bashrc or .zshrc, and change the index file name and vimwiki path to ones that fit your config. Notice the script assumes the .md extension.)
