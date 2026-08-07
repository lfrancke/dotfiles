alias ll = ls -l

alias vim = nvim
alias vi = nvim

alias dl   = cd ~/Downloads
alias dev  = cd ~/dev
alias devs = cd ~/dev/stackable
alias deve = cd ~/dev/external
alias devo = cd ~/dev/opencore

# Claude Code runs inside the nono sandbox by DEFAULT — `claude` is the sandboxed
# path, so the safe thing is the lazy thing.
#
# Profile selection, first match wins:
#   claude --sandbox intranet        just this invocation
#   $env.NONO_PROFILE = 'intranet'   rest of this shell (nono reads this natively)
#   neither                          dev — personal layer over the team baseline
#
# `--wrapped` forwards everything else to claude untouched, including quoted
# arguments: `claude -p 'a long prompt'` arrives as one argument, not three.
# That was the original reason for using an alias here; --wrapped covers it.
def --wrapped claude [--sandbox: string = "", ...args] {
  let profile = if ($sandbox | is-empty) { $env.NONO_PROFILE? | default "dev" } else { $sandbox }
  nono run --profile $profile -- claude ...$args
}

# Deliberate escape hatch: unsandboxed, full credentials in reach. Use only when
# you actually mean it (e.g. debugging the sandbox itself).
alias rawclaude = ^claude

# Kept for muscle memory. noclaude-k8s is now just `claude --sandbox minikube`,
# but minikube also needs its apiserver IP through the network filter, which nono
# reads from NONO_ALLOW_DOMAIN before the profile resolves — so it stays a def:
def --wrapped noclaude [...args] { claude ...$args }
def --wrapped noclaude-k8s [...args] {
  with-env {NONO_ALLOW_DOMAIN: (minikube ip)} { claude --sandbox minikube ...$args }
}

def dbash [image] { docker run -it --rm --entrypoint bash $image }
def kbash [image] { kubectl run (random chars --length 20 | str lowercase ) --rm -it --image $image -- bash }

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

