# Oh-my-Zsh prompt created by gianu
#
# github.com/gianu
# sgianazza@gmail.com
#➜
#PROMPT='[%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%}] $(git_prompt_info)%{$reset_color%} $ '


ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color$fg_bold[blue]%}git:(%{$reset_color$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color$fg_bold[blue]%}) %{$resrt_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color$fg_bold[blue]%}) %{$reset_color%}✗ "

rvm_current() {
      rvm current 2>/dev/null
}
 
PROMPT='
%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} $(git_prompt_info) %{$reset_color%}
$ '

RPROMPT='%{$fg_bold[red]%}$(rvm_current)%{$reset_color%}'
