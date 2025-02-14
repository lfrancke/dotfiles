alias ll = ls -l

alias dl   = cd ~/Downloads
alias dev  = cd ~/dev
alias devs = cd ~/dev/stackable
alias deve = cd ~/dev/external
alias devo = cd ~/dev/opencore

def dbash [image] { docker run -it --rm --entrypoint bash $image }
def kbash [image] { kubectl run (random chars --length 20 | str downcase ) --rm -it --image $image -- bash }

alias cat = bat

# As of 2024-11 this is needed to convince Zellij to draw images
# This is straight from the yazi README, maybe it's gone later
def --env y [...args] {
  $env.NVIM = "0"
  $env.NVIM_LOG_FILE = "1"
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}

