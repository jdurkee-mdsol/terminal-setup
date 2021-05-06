alias ls="exa -hgbH --git"
alias ll="exa -lhgbH --git"
alias la="exa -lahgbH --git"
alias aws=~/.aws-cli/aws
alias cat=bat
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias du='dust'
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias h='history'

alias dc='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory .'
alias dcb='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory . build'
alias dce='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory . exec'
alias dcr='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory . run --rm'
alias db='DOCKER_BUILDKIT=1 docker build --ssh default -f .12factor/Dockerfile --build-arg BUNDLE_WITHOUT="" -t'
