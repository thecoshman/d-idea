# intelij-container
InteliJ IDE dockerised 

# Scope

Pretty much just the latest (2017.1.4) InteliJ CE with OpenJDK8, no additional plugins or what not. I may add more later, but for now, that's it. 

This is primarily for myself to use for Kotlin dev, but obviously is good for the likes of Java, Groovy, Scala etc.

# Usage

Start with the following very concise command:

```
docker run -tdi \
    --net=host \
    -e DISPLAY=${DISPLAY} \
    -v ~/.Xauthority:/root/.Xauthority \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/.intelij/.IdeaIC2017.1:/root/.IdeaIC2017.1 \
    -v ~/.intelij/.java:/root/.java \
    -v ~/.intelij/IdeaProjects:/root/IdeaProjects \
    thecoshman/intelij-container
```

If only there was someway to make that easier to use, `*cough*` alias.

Volume mounts `~/.intelij/*` in your home folder are to persist a few things between executions of the container. The first time you run this you will have to accept the licence and set some profile stuff, but after that, it's saved in your own home folder, along with projects. 

Don't go changing the location of where InteliJ stores porjects files, as any other location will not be persisted; you can update the volume though.

# Tags

I am only going to tag `latest` as I update this. If anyone would like me to start tagging specific builds with specific versions of InteliJ, then just log an issue on github. Otherwise, I'll just consider it a waste of time :P

# X11 magic

Getting the X11 stuff to work is fairly simple, it's all down to the invocation with the `docker run` command. To be clear, it's the `--net=host -e DISPLAY=${DISPLAY} ~/.Xauthority:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix` that allows the image to make use of your host's X11 server.

# Credits & Acknowledgments 

First of all, shout out to [Vlad Frolov](https://github.com/frol) who provides the base image. He worked through issues with Java not running in Alpine. tl;dr Alpine isn't compatible with Java and requires some messing around to get stuff working.

I also got a good start on this thanks to [dlsniper's](https://hub.docker.com/r/dlsniper/docker-intellij/) work on this same idea. Though he was building his container for Go dev and also seems to have stopped updating.

# Contributing

Please feel free to raise issues in github to improve anything or add any details you feel are good to add. 
