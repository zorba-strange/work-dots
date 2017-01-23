# Greeting for every new session
function Hello {
  me=$(whoami)
  echo Gee, me, what do you want to do tonight?
  echo The same thing we do every night, me - try to take over the world!
  echo 
}
export Hello

# 	Show git brach on prompt (I should remember who I stole this from
# 	and credit him or her) 
function prompt_git() {
  #    this is >5x faster than mathias's.
  #    check if we're in a git repo. (fast)
  git rev-parse --is-inside-work-tree &>/dev/null || return
  #   check for what branch we're on. (fast)
  #   if… HEAD isn’t a symbolic ref (typical branch),
  #   then… get a tracking remote branch or tag
  #   otherwise… get the short SHA for the latest commit
  #   lastly just give up.
  branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
    git describe --all --exact-match HEAD 2> /dev/null || \
    git rev-parse --short HEAD 2> /dev/null || \
    echo '(unknown)')";


  ## early exit for Chromium & Blink repo, as the dirty check takes ~5s
  ## also recommended (via goo.gl/wAVZLa ) : sudo sysctl kern.maxvnodes=$((512*1024))
  repoUrl=$(git config --get remote.origin.url)
  if grep -q chromium.googlesource.com <<<$repoUrl; then
    dirty=" ⁂"
  else

    # check if it's dirty (slow)
    #   technique via github.com/git/git/blob/355d4e173/contrib/completion/git-prompt.sh#L472-L475
    dirty=$(git diff --no-ext-diff --quiet --ignore-submodules --exit-code || echo -e "*")

    # mathias has a few more checks some may like:
    #    github.com/mathiasbynens/dotfiles/blob/a8bd0d4300/.bash_prompt#L30-L43
  fi


  [ -n "${s}" ] && s=" [${s}]";
  echo -e "${1}${branchName}${2}$dirty";

  return
}

#   PS1
PS1="\\[\e[1;35m\u \W : \$\[\033[0m\] "
PS1+="\[(\]\$(prompt_git \"$white on $purple\" \"$cyan\")\[ ) \]"
export PS1

#   Alias
alias ls="ls -aC"
alias ll="ls -alFhG"

alias mkdir="mkdir -pv"

alias o="open"

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."

alias x="clear"

#   Git Alias
alias ga="git add"
alias gcm="git commit -m"
alias gs="git status"

# 	Git commands
alias gl='git log --all --decorate --graph --pretty=format:"%C(yellow)%h%Creset %C(auto)%d%Creset %Cblue%ar%Creset %Cred%an%Creset %n%w(72,1,2)%s"'
alias gs="git status"

#   Open folders
alias dot="cd /Users/zorbaStrange/dotfiles"
alias games="cd /usr/share/emacs/22.1/lisp/play"
alias down="cd Downloads"
alias app="cd Applications"
alias projects="cd projects"

#   Open files
alias vbash="vim /Users/zorbaStrange/dotfiles/.bash_profile"
alias bashp="source /Users/zorbaStrange/dotfiles/.bash_profile" 

alias weather="telnet rainmaker.wunderground.com"
alias vvim="vim /Users/zorbaStrange/dotfiles/.vimrc"

#   PATH 
export PATH=/Library/PostgreSQL/9.5/bin:$PATH
export PATH=/Users/zorbaStrange/dotfile/.bash_profile:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/Users/zorbaStrange/bash_scripts:$PATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
export GITHUB_USERNAME='zorba-strange'
