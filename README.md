# Docker Image Information

This docker image is what the pwncollege runs when the user starts a challenge.

My docker image is based on the base pwn.college challenge-legacy image.  The
challenge-legacy is 13.8 GB in size.  I thought we could probably trim out some
of the items in that image, and then include some tools more helpful for high
school students starting with Linux.  Basic things I tried to update from what
pwn.college had originally:

* Updated image to Ubuntu 24.04 LTS base (it was 20.04)
* Removed custom kernel
* Removed busybox
* Removed anything that needed to be installed via pip (installed most of the
  same tools via Ubuntu packages)

This docker image is currently around 4.93 GB, significantly lighter.

Many of the tools used by pwncollege are somehow mounted via local shares, and
we don't need to install these tools ourselves.

* Binary Ninja
* Ghidra
* IDA Proo

# Package Updates

## New things I want to add

[x] NES Emulators (FCEux for debugger, nestopia to run contra polyglot)
[ ] ImHex editor (this might be overkill)
[x] ghex
[x] rot13 (bsdgames)
[x] cowsay
[x] ristretto (lightweight xfce image viewer)
[x] nano
[x] rar and unrar
[x] steghide, stegsnow, outguess
[x] meld (lightweight diff viewer.  kompare if distro was Qt based)

## Things that would be nice to have, but will pass for now

On my normal system I would probably also install the following tools, but I
don't think it will be neccessary for this

* geany
* gimp
* okular (really fast PDF reader, a must for large processor manuals)
* 010editor (not free)

## Things I want to remove

[x] racket (380MB) - newer programming language

## Things that should be redone

[x] capstone is compiled from git commit with specific hash, but has a
    libcapstone-dev, libcapstone, and python3-capstone packages
[x] tcpdump is compiled, and source / temps all left in the image

# Sharing the image

I updated this image to hub.docker.com.  That way the pwn.college instances
can download it.  This image is also used to build the challenges (you will
see podman scripts in the chal_crafting folder)

# Instructions to build and upload the image

```
# Login to dockerhub

docker build -t mwales/pwncollege_test:release_version .

# Upload to dockerhub
docker push mwales/pwncollege_test:release_version
```

Change the release_version that is in dojo.yml to match the new version.

You can test some stuff out locally after building by starting the image
in local docker container

```
docker run --rm -it mwales/chal_test:release_version /bin/bash
```

## Things we should add instructions for / figure out

[ ] How to test out the docker image as root user (not hacker user)
[ ] How to launch the docker image in desktop mode like it's hosting
    a challenge
[ ] Would be great to just mount a directory into docker image and
    have it simulate the challenge as run in pwncollege

