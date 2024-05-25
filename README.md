# d-idea

IntelliJ IDE dockerised!

# Scope

Pretty much just the latest IntelliJ CE with OpenJDK21, no additional plugins or what not.
I may add more later, but for now, that's it.

This is primarily for myself to use for Kotlin dev, but obviously is good for the likes of Java, Groovy, Scala etc.

# Usage

Start the container with the following very concise command:

```
xhost +local:docker
docker run -tid \
    --net=host \
    -e DISPLAY=${DISPLAY} \
    -v ~/.Xauthority:/root/.Xauthority \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/.intellij/:/root/ \
    thecoshman/d-idea
```

If only there was someway to make that easier to use, `*cough*` alias.

The volume mount `~/.intellij/` in your home folder is to persist a few things between executions of the container.
The first time you run this you will have to accept the license and set some profile stuff, but after that, it's saved in your own home folder, along with projects.
Upgrading between main releases of InteliJ (such as from 2017.1 to 2017.2) will require you 'import' settings (if you want) and these to persist.

Don't go changing the location of where IntelliJ stores projects files, as any other location will not be persisted; you can update the volume mount though.

# Tags

I am only going to tag `latest` as I update this.
If anyone would like me to start tagging specific builds with specific versions of IntelliJ, then just [log an issue](https://github.com/thecoshman/d-idea/issues).
Otherwise, I'll just consider it a waste of time :P

# X11 magic

Getting the X11 stuff to work is fairly simple, it's all down to the invocation with the `docker run` command, combined with `xhost`.
To be clear, it's the `--net=host -e DISPLAY=${DISPLAY} ~/.Xauthority:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix` that allows the image to make use of your host's X11 server.
Prior to starting the container you would runbn `xhost +local:docker` (no `sudo` required!) which will allow connections to your X11 server;
honestly don't fully understand what it is doing.

# Notes about installed packages

There's a few packages that are installed in the Dockerfile for the various reasons.
As some sort of documentation, here's what is installed along with why.

* `e2fsprogs` - Resolves a startup error for InteliJ wanting the `e2p` library
* `fontconfig` & `msttcorefonts-installer` - For basic font handling in InteliJ, seems to be required
* `gcompat` - The `glib` compatibility required for the JDK
* `openjdk21` - The JDK obviously

# Credits & Acknowledgments 

First of all, shout out to [Vlad Frolov](https://github.com/frol) who provided the original base image.
They worked through issues with Java not running in Alpine.
tl;dr Alpine isn't compatible with Java and requires some messing around to get stuff working.
However, I have since learned I can get away with using the standard Alpine image and install glibc.

I also got a good start on this thanks to [dlsniper's](https://github.com/dlsniper/docker-intellij) work on this same idea.
Though they were building their image for Go dev and seems to have stopped updating.

# Contributing

Please feel free to raise issues or pull requests in github to improve anything or add any details you feel are good to add.
