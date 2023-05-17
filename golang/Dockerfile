ARG golang_version=1.16
FROM golang:$golang_version

# Arguments defined in docker-compose.yml
ARG user=kore
ARG uid=1000
ARG go_path=/var/www/project

ENV GOPATH=$go_path

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
	chown -R $user:$user /home/$user

RUN apt-get update && apt-get install -y \
	vim \
	curl \
	mcrypt \
	libmcrypt-dev

USER $user

RUN go install gotest.tools/gotestsum@latest
RUN go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest
RUN go install github.com/ramya-rao-a/go-outline@latest
RUN go install github.com/cweill/gotests/gotests@latest
RUN go install github.com/fatih/gomodifytags@latest
RUN go install github.com/josharian/impl@latest
RUN go install github.com/haya14busa/goplay/cmd/goplay@latest
RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install golang.org/x/lint/golint@latest
RUN go install golang.org/x/tools/gopls@latest
RUN go install honnef.co/go/tools/cmd/staticcheck@latest
RUN curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sh -s -- -b $(go env GOPATH)/bin

RUN echo "export PATH=\$PATH:\$HOME/go/bin" >> /home/$user/.bashrc

RUN mkdir -p /home/$user/.vscode-server

WORKDIR /var/www