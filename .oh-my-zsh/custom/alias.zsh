alias s="eza -hgbH --git"
alias ll="eza -lhgbH --git"
alias la="eza -lahgbH --git"
alias aws=~/.aws-cli/aws
alias cat=bat
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias du='dust'
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias h='history'

#alias dc='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory .'
#alias dcb='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory . build'
#alias dce='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory . exec'
#alias dcr='DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f .12factor/docker-compose.yml --project-directory . run --rm'
alias db='DOCKER_BUILDKIT=1 docker build --ssh default --secret id=artifactory,src=.artifactory -f .12factor/Dockerfile --build-arg BUNDLE_WITHOUT="" -t'
alias dc='docker compose -f .12factor/docker-compose.yml --project-directory .'
alias dcb='docker compose -f .12factor/docker-compose.yml --project-directory . build'
alias dce='docker compose -f .12factor/docker-compose.yml --project-directory . exec'
alias dcr='docker compose -f .12factor/docker-compose.yml --project-directory . run --rm'
alias migrate='dcr rails bundle exec rails db:migrate'
alias run='dc up --build rails'
alias con='dcr rails bundle exec rails c'
alias exe='dce rails bash'

alias aws='docker run --rm -v $(pwd)/.kube:/root/.kube -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias aws-ssm='docker run --rm -it -v $(pwd)/.kube:/root/.kube -v ~/.aws:/root/.aws -v $(pwd):/aws aws-ssm'
alias aws_o='docker run -e PAGER="" --rm -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias laws='docker run --network localstack --rm -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli --profile localstack'
alias kaws='docker run --rm -it -v $(pwd)/.kube:/root/.kube -v ~/.aws:/root/.aws -v $(pwd):/aws --entrypoint="" aws-ssm kubectl'

alias ecr-login='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 767904627276.dkr.ecr.us-east-1.amazonaws.com'
