# vim:ft=zsh ts=2 sw=2 sts=2

rvm_current() {
  rvm current 2>/dev/null
}

rbenv_version() {
  rbenv version 2>/dev/null | awk '{print $1}'
}

if [[ $USER == "root" ]]; then
  CARETCOLOR="red"
else
  CARETCOLOR="white"
fi


PROMPT='%{$fg[red]%}➜ %{$reset_color$fg[green]%}%n %{$fg_bold[blue]%}:: %{$reset_color%}%{$FX[bold]${FG[087]}%}$(echo "${PWD/#$HOME/~}" | perl -pe "s/(\/)?(\.)?(.)[^\/]*\//\$1\$2\$3\//g") $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color$fg_bold[blue]%}git:(%{$reset_color$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color$fg_bold[blue]%}) %{$resrt_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color$fg_bold[blue]%}) %{$reset_color%}✗ "

RPROMPT='%{$fg_bold[red]%}$(rbenv_version)%{$reset_color%}'
