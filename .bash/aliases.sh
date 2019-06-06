alias c='clear'
alias ..='cd ../'
alias x='exit'

alias ic='ping google.com'
alias lsd='ls -d */'
alias svnlog='svn log -v --limit 6 | less'
alias fnd='find ./ -name '

alias vi=nvim
alias vim=nvim

alias gst='git status'
alias gc='git commit'
alias gco='git checkout'

if [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git
  __git_complete gst _git_status
  __git_complete gc  _git_commit
  __git_complete gco _git_checkout
fi

alias short='grep -Ev ".{120}"'
