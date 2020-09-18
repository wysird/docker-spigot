# SpigotMC

Thanks to the trusty [`BuildTools`](https://www.spigotmc.org/wiki/buildtools) application, it has been made incredibly easy to container-ise SpigotMC. This image is not quite ready for production/load-balancing use (similar to the system used by [`Minehut`](https://minehut.com)), but offers a very quick server setup.

All images are based on [`openjdk:8-jre`](https://hub.docker.com/layers/openjdk/library/openjdk/8-jre/images/sha256-ddd01a366e0de0b8a7880726e1e69804eef67b2cd747ef5588cbfa9e2c20c0f5), which is currently compatible with all plugins.



## Quick Start

```
docker run --name spigotmc -v ${PWD}/minecraft:/minecraft -p 25565:25565 wysird/spigot:1.16.3
```

## Quick Start (Docker-Compose)
```
version: '3.8'
services:
  spigotmc:
    image: wysird/spigot:1.16.3
    ports:
      - 25565:25565
    volumes:
      - ${PWD}/minecraft:/minecraft
```


## Interactive
Sometimes you might wish to run this image interactively (so you can enter commands directly to the server).

To do this with the docker command you can add the `-i` and `-t` flags to the arguments:
```
docker run -it ... wysird/spigot:1.16.3
```

To do this with docker-compose, you will have to add the following options to your service:

[`stdin_open` and `tty`](https://docs.docker.com/compose/compose-file/#domainname-hostname-ipc-mac_address-privileged-read_only-shm_size-stdin_open-tty-user-working_dir):
```
version: '3.8'
services:
  spigotmc:
    image: wysird/spigot:1.16.3
    ...
    stdin_open: true
    tty: true
    ...
```
(Obviously this service now can't be run 'detached' so make sure you __DON'T__ include the `-d` command when running `docker-compose up`).

## Volumes

All data is stored in `/minecraft`. Mount this to somewhere you can edit the `eula.txt` file to agree to it after first running this image.



## Environment Variables

- __JVM_ARGS__: Arguments to be passed into the Java Virtual Machine (e.g. `-Xmx4G -Xms2G`)
- __MAX_MEM__: Maximum amount of memory that the JVM is allowed to use (e.g. `4G`)
- __MIN_MEM__: Minimum amount of memory allocated for the JVM (e.g. `2G`)
- __SPIGOT_ARGS__: Arguments to be passed into the Spigot JAR at run time (e.g. `nogui`) - Default: `nogui`


## Troubleshooting

You may have to open up the directory that you mount to `/minecraft` for all users to access it (e.g. `chmod 0777 ${PWD}/minecraft`).



## Future plans

At the moment it is not possible to execute commands on the server itself. Instead you have to add yourself to the `ops.json`/`ops.txt` file manually, and execute the commands from a client. This will be possible in future versions (all current tags will be replaced with this when I've worked out how to do it).