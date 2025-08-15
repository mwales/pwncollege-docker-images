# syntax=docker/dockerfile:1-labs

FROM mwales/pwncollege_base:beta05

USER root

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && xargs apt-get install --no-install-recommends -yqq <<EOF && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
        xfce4
        tigervnc-standalone-server
        dbus-x11
        xfonts-base
        xfonts-75dpi
        xfonts-100dpi
        xfonts-encodings
        xfonts-utils
        xfonts-traditional
        libxfont2
        xterm
        libpixman-1-0
EOF

RUN ln -s /etc/X11/fonts/100dpi /etc/X11/fonts/misc

RUN adduser hacker sudo
RUN chmod u+s /usr/bin/sudo

COPY internal_launch_desktop.sh simulate_pwn_college.sh /home/hacker
RUN chmod 0755 /home/hacker/internal_launch_desktop.sh /home/hacker/simulate_pwn_college.sh

USER hacker
WORKDIR /home/hacker

CMD [ '/home/hacke/simulate_pwn_college.sh' ]
