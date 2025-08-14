# syntax=docker/dockerfile:1-labs

FROM ubuntu:24.04

SHELL ["/bin/bash", "-ceov", "pipefail"]

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_CTYPE=C.UTF-8

RUN <<EOF
    rm -f /etc/apt/apt.conf.d/docker-clean
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache

    (set +o pipefail; yes | unminimize)

    dpkg --add-architecture i386

    apt-get clean && rm -rf /var/lib/apt/lists/*
EOF

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && xargs apt-get install --no-install-recommends -yqq <<EOF && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
        build-essential
        ca-certificates
        curl
        python-is-python3
        sudo
        wget
        unzip
EOF

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && xargs apt-get install --no-install-recommends -yqq <<EOF && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
        autoconf
        bc
        bison
        cargo
        clang
        cmake
        cpio
        openjdk-17-jdk
        flex
        dwarves
        g++-multilib
        gcc-multilib
        git
        libc6-dev-i386
        libc6:i386
        libedit-dev
        libelf-dev
        libffi-dev
        libglib2.0-dev
        libgmp-dev
        libini-config-dev
        libncurses6:i386
        libpcap-dev
        libpixman-1-dev
        libseccomp-dev
        libssl-dev
        libstdc++6:i386
        libtool-bin
        llvm
        man-db
        manpages-dev
        nasm
        python-is-python3
        python3-dev
        python3-pip
        rubygems
        squashfs-tools
        upx-ucl
EOF

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && xargs apt-get install --no-install-recommends -yqq <<EOF && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
        apache2
        arping
        bash-builtins
        bat
        binutils
        binutils-aarch64-linux-gnu
        binwalk
        bsdgames
        bsdmainutils
        bsdutils
        cowsay
        debianutils
        diffutils
        ed
        elfutils
        emacs
        ethtool
        exiftool
        expect
        figlet
        findutils
        finger
        firefox
        fish
        fortune
        fortunes
        gcc-aarch64-linux-gnu
        gdb
        gdb-multiarch
        gedit
        ghex
        genisoimage
        gnupg-utils
        gprolog
        hexedit
        icdiff
        iproute2
        iptables
        iputils-ping
        ipython3
        john
        jq
        keyutils
        kmod
        kompare
        less
        libapache2-mod-php
        libc6-arm64-cross
        libc6-dev-arm64-cross
        capstone-tool
        libcapstone-dev
        ltrace
        mysql-server
        nano
        neovim
        net-tools
        netcat-openbsd
        nmap
        openssh-server
        p7zip-full
        parallel
        patchelf
        pcaputils
        pcre2-utils
        php-cgi
        php-mysql
        psutils
        python3-ipdb
        python3-magic
        qemu-system-x86
        qemu-user
        qemu-utils
        ristretto
        rsync
        screen
        silversearcher-ag
        socat
        sqlite3
        steghide
        stegsnow
        outguess
        strace
        tcpdump
        tmux
        toilet-fonts
        valgrind
        vim
        wamerican
        whiptail
        wireshark
        zip
        rar
        unrar
        zsh
EOF
################################################################################

# gdb

RUN <<EOF
    git clone --depth 1 --recurse-submodules --branch 2024.02.14 https://github.com/pwndbg/pwndbg /opt/pwndbg
    cd /opt/pwndbg
    ./setup.sh

    git clone --depth 1 https://github.com/hugsy/gef /opt/gef

    git clone --depth 1 https://github.com/jerdna-regeiz/splitmind /opt/splitmind

    ln -sf /home/hacker/.gdbinit /root/.gdbinit
EOF

################################################################################

RUN <<EOF
    wget -q -O - https://github.com/mozilla/geckodriver/releases/download/v0.35.0/geckodriver-v0.35.0-linux64.tar.gz | tar xvz -C /usr/local/bin
EOF

RUN <<EOF
    VERSION="1.5.1"
    DEB_NAME="glow_${VERSION}_amd64.deb"
    pushd /tmp
    wget -q "https://github.com/charmbracelet/glow/releases/download/v${VERSION}/${DEB_NAME}"
    apt install "./${DEB_NAME}"
    rm "${DEB_NAME}"
    popd
EOF

RUN <<EOF
    mkdir /opt/virtiofsd && cd "$_"
    wget -q -O ./build.zip "https://gitlab.com/virtio-fs/virtiofsd/-/jobs/artifacts/main/download?job=publish"
    unzip -p ./build.zip "$(zipinfo -1 ./build.zip | head -n1)" > ./virtiofsd
    rm -f ./build.zip
    chmod +x ./virtiofsd
EOF

################################################################################

# python pip (formerly pip packages)

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && xargs apt-get install --no-install-recommends -yqq <<EOF && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
        python3-asteval
        python3-capstone
        python3-flask
        python3-pwntools
        python-pwntools-doc
        python3-scapy
        python3-jupyter-core
        python3-jupyter-client
        python3-jupyter-console
        python3-jupyter-server
        python3-psutil
        python3-pycryptodome
        python3-requests
        python3-selenium
        fceux
        ares
EOF

RUN ln -sf /usr/bin/ipython3 /usr/bin/ipython

################################################################################

RUN mkdir /opt/pwn.college
COPY docker-initialize.sh /opt/pwn.college/docker-initialize.sh
COPY docker-entrypoint.d /opt/pwn.college/docker-entrypoint.d
COPY docker-entrypoint.sh /opt/pwn.college/docker-entrypoint.sh
COPY bash.bashrc /opt/pwn.college/bash.bashrc
COPY vm /opt/pwn.college/vm
COPY .tmux.conf /opt/pwn.college/.tmux.conf
COPY .gdbinit /opt/pwn.college/.gdbinit
COPY .radare2rc /opt/pwn.college/.radare2rc
COPY .pwn.conf /opt/pwn.college/.pwn.conf

COPY suid_interpreter.c /tmp/suid_interpreter.c
RUN gcc -o /opt/pwn.college/python -D SUID_PYTHON /tmp/suid_interpreter.c && \
    gcc -o /opt/pwn.college/bash -D SUID_BASH /tmp/suid_interpreter.c && \
    gcc -o /opt/pwn.college/sh -D SUID_SH /tmp/suid_interpreter.c && \
    rm -f /tmp/suid_interpreter.c

RUN <<EOF
    ln -sf /opt/pwn.college/vm/vm /usr/local/bin/vm

    ln -sf /home/hacker/.tmux.conf /root/.tmux.conf
    ln -sf /home/hacker/.gdbinit /root/.gdbinit
    ln -sf /home/hacker/.radare2rc /root/.radare2rc
    ln -sf /home/hacker/.pwn.conf /root/.pwn.conf

    mkdir /challenge
    install -m 400 <(echo 'pwn.college{uninitialized}') /flag
EOF

RUN <<EOF
    if [ -f /etc/ssh/ssh_config ]
    then
        echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
        echo "UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config
        echo "LogLevel ERROR" >> /etc/ssh/ssh_config
    fi

    if [ -f /etc/ssh/sshd_config ]
    then
        sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
        sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
    fi

    if id ubuntu; then userdel -f -r ubuntu; fi
    useradd -s /bin/bash -m hacker
    passwd -d hacker

    echo -e '\n[ "$UID" -eq 1000 ] && . /opt/pwn.college/bash.bashrc' >> /etc/bash.bashrc
    ln -s /etc/bash.bashrc /etc/bashrc

    find / -xdev -type f -perm -4000 -exec chmod u-s {} \;

    chmod u+s /opt/pwn.college/python
    chmod u+s /opt/pwn.college/bash
    chmod u+s /opt/pwn.college/sh
    chmod u+s /opt/pwn.college/vm/vm

    date > /opt/pwn.college/build
EOF

ADD --chown=0:0 --chmod=6755 http://github.com/pwncollege/exec-suid/releases/latest/download/exec-suid /usr/bin/exec-suid

RUN <<EOF
    ln -sf /usr/bin/python /usr/local/bin/python
    ln -sf /usr/bin/python3 /usr/local/bin/python3
EOF

USER hacker
WORKDIR /home/hacker
