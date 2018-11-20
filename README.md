# docker-phpstorm

Jetbrains PhpStorm 2018.2 running inside a docker container. This project is derived from [`fgrehm/docker-netbeans`](https://github.com/fgrehm/docker-netbeans).

## Features

* PhpStorm 2018.2.3
* PHP 7.2
* composer
* graphviz

There is a PHP5 based container in the [`master`](https://github.com/iainmckay/docker-phpstorm) branch.

## Running

To launch PhpStorm we need to provide the current display and your X11 socket. You can launch PhpStorm with the following command:

```sh
    $ docker run -it --rm \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v ~/.PhpStorm2018.2:/home/developer/.PhpStorm2018.2 \
        -v ~/Projects:/workspace \
        iainmckay/phpstorm:2018.2-php7
```

With this your configuration will be persisted to `/home/<user>/.PhpStorm2018.2` so that you don't lose it over subsequent runs. It also makes any sourcecode under `/home/<user>/Projects` available to PhpStorm. Inside the dockerized environment, it will be available through `/workspace`.

Note: Remember to change the ownership of the config directory on the host as it will be created as root if it does not already exist and PhpStorm won't be able to write to it.

## Xdebug

An environmental values for xdebug.ini configuration may be setup from an example .env.example and appending `--env <custom_env_file>` to the command

## Adding to your launcher

There is a desktop launcher provided in `support/launcher`. You should place `phpstorm.desktop` in `~/.local/share/applications` and place `phpstorm.png` in `~/.local/share/icons`.

You may need to logout and log back in for it to be detected.
