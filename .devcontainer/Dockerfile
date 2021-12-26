ARG VARIANT=16-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
    && apt install -y \
        libgtkextra-dev libgconf2-dev libnss3 libasound2 \
        libxtst-dev libxss1 libgtk-3-0 curl zip unzip xorg \
        build-essential git locales sudo libatk-bridge2.0-0 \
        libgtk-3-dev packagekit-gtk3-module libcanberra-gtk-module \
    && locale-gen ja_JP.UTF-8 \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8
ENV QT_X11_NO_MITSHM=1

ENV USERNAME=node
RUN echo "root:root" | chpasswd \
    && echo "${USERNAME}:${USERNAME}" | chpasswd \
    && echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}
USER ${USERNAME}

RUN npm install electron -g

# Run "echo $DISPLAY" on the host PC and set the displayed string
ENV DISPNO=:1
RUN echo "export DISPLAY=${DISPNO}" >> ${HOME}/.bashrc