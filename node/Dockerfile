ARG NODE_VERSION=lts

FROM node:${NODE_VERSION}

ARG Y_V=stable
ARG USER=node

USER ${USER}

#RUN cd /home/$USER && \
#    yarn set version $Y_V

# Create a directory for the npm cache and adjust the permissions
RUN mkdir -p /home/${USER}/.npm && \
	chmod 777 /home/${USER}/.npm

RUN mkdir -p /home/$USER/.vscode-server

WORKDIR /var/www