## The official Bolt Docker Image

This is also the image that powers the container Bolt demo sites on https://try.bolt.cm 
and https://market.bolt.cm.

It uses Apache, PHP-FPM and SQLite in a single service.

It should be used in production with a separate http proxy container, we'd recommend
jwilder/nginx-proxy which will allow you to define a virtual host for each container.

### Supported Tags

* `3.4`, `latest`
* `3.3`,
* `3.2`


### Releases

This repo by default uses SQLite requesting the version number only will fetch this
There is now experimental mysql support which you can specify by prefixing `mysql-` to
the release tag.

As new versions are released we will tag a corresponding version for the image. You can
always leave the tag empty or define `latest` which will have the same effect of installing
the latest stable version.


### Quick Start

All you need to do to get started is pull the image and then launch a container.

```bash
docker pull rossriley/docker-bolt
```

If you want to specify a specific tag then append that as below

```bash
docker pull rossriley/docker-bolt:3.3
```

Once the pull has completed then you can launch a container using the `docker run` command,
there are a few additional environment variables that you can pass, the one shown below installs
the default Bolt theme.

```bash
docker run -p 80 --name my_bolt_site -e BOLT_EXT='bolt/theme-2016 dev-master' -e BOLT_TITLE='My Bolt Site' -e BOLT_THEME='bolt/theme-2016' -d -t rossriley/docker-bolt
```

### Using Docker-Compose

If you use `docker-compose` then all you need is a `docker-compose.yml` file that looks something 
like this:

```yaml
version: '2'

services:
    bolt:
        image: rossriley/docker-bolt:3.4
        network_mode: bridge
        environment:
            - BOLT_EXT=bolt/theme-2016 dev-master
            - BOLT_TITLE=My Bolt Site
            - BOLT_THEME=bolt/theme-2016
        volumes:
            - ./db-data:/var/www/html/app/database
            - ./files:/var/www/html/public/files
            - ./extensions:/var/www/html/extensions
```

This config will get you the latest 3.4.x release, note the additional environment variables
you can set to install and configure a theme, in this case the default Bolt theme.

A few volumes are also defined here which will allow you to persist the database, files
and extensions to the host.

Please note that you may want to define additional persistent volumes here depending on what
files you allow the admin users to edit.