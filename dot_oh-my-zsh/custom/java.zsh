{{ if eq .chezmoi.os "darwin" -}}
export M2_HOME=/usr/local/Cellar/maven/3.5.4/libexec
export JAVA_HOME=$(/usr/libexec/java_home)
{{ end -}}
