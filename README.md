PHP-FPM Alpine w/xDebug [![GitHub file size](https://img.shields.io/github/size/webcaetano/craft/build/phaser-craft.min.js.svg?style=for-the-badge)](https://github.com/saidatom/fpm-alpine)
=============

This repo contains a recipe for making a [Docker](http://docker.io) container for Drupal, using Linux, Apache and PHP7.2-FPM.
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/).

This will try to go in line with [Drupal automated-testing](https://drupal.org/automated-testing).

## And run the container, connecting port 9000:
```
docker run --rm -p 9000:9000 -v /path/of/application:/application saidatom/fpm-alpine
```

Docker environment on your Mac will have `10.254.254.254` as an alias on your loopback device (`127.0.0.1`). The command being run is `ifconfig lo0 alias 10.254.254.254`.

## Authors

Created and maintained by [Alexandre Dias][author] (<alex.jm.dias_at_gmail.com>)

## License
GPL v3

[author]:                 https://github.com/saidatom
