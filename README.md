# docker-phpstorm

Jetbrains PhpStorm 10.0.1 running inside a docker container. This project is derived from [`fgrehm/docker-netbeans`](https://github.com/fgrehm/docker-netbeans).

## Features

* PhpStorm 10.0.1
* PHP 5.6
* composer

## Running

To launch PhpStorm we need to provide the current display and your X11 socket. You can launch PhpStorm with the following command:

```sh
    $ docker run -it --rm \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v ~/.WebIde100:/home/developer/.WebIde100 \
        -v ~/Projects:/workspace \
        iainmckay/phpstorm:latest
```

With this your configuration will be persisted to `/home/<user>/.WebIde100` so that you don't lose it over subsequent runs. It also makes any sourcecode under `/home/<user>/Projects` available to PhpStorm. Inside the dockerized environment, it will be available through /workspace.

Note: Remember to change the ownership of the config directory on the host as it will be created as root if it does not already exist and PhpStorm won't be able to write to it.

## Adding to your launcher

There is a desktop launcher provided in `support/launcher`. You should place `phpstorm.desktop` in `~/.local/share/applications` and place `phpstorm.png` in `~/.local/share/icons`.

You may need to logout and log back in for it to be detected.
