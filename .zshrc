# Path to your oh-my-zsh configuration.
ZSH=/usr/local/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="awesomepanda"

#ZSH_THEME="spectre"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ggrep="git grep -n"
alias rpm_show_files='rpm -q --queryformat "[%-30{NAME} %-50{FILENAMES} %10{FILESIZES}\n]" -a'

alias pretest_update='telnet pre.test.mail.ru 1789'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=1300

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export CC="/usr/local/bin/gcc-4.9"
export CXX="/usr/local/bin/g++-4.9"
export AR="/usr/local/bin/gcc-ar-4.9"
export LUA_PATH="~/luaunit/?.lua;$LUA_PATH"
export LESSCHARSET=utf-8

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#bindkey -v
bindkey '^R' history-incremental-search-backward

ulimit -c unlimited

PAGER='less -F -X'

transfer() {
    if [ $# -eq 0 ]; then
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
    fi
    tmpfile=$( mktemp -t transferXXX );
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://t.bk.ru/$basefile" >> $tmpfile;
    else
        curl --progress-bar --upload-file "-" "https://t.bk.ru/$1" >> $tmpfile;
    fi;
    cat $tmpfile;
    rm -f $tmpfile;
}

alias rpmfind='wget http://pkg.corp.mail.ru/find.rpm.list.txt -O - 2>/dev/null|perl -pe "s#^#http://pkg.corp.mail.ru/#" | fgrep'

PATH="/Users/p.bereznoy/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/Users/p.bereznoy/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/p.bereznoy/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/p.bereznoy/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/p.bereznoy/perl5"; export PERL_MM_OPT;

alias ls="ls -G"

alias justpass="openssl rand -base64 32"

export PATH="/Library/TeX/texbin:$PATH"
