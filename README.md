# NEST Desktop Docker

Docker container for NEST Desktop and NEST Simulator.

For more information, please see the [User Documentation Page of NEST Desktop](https://nest-desktop.readthedocs.io) as well as the [User Documentation Page of NEST Simulator](https://nest-simulator.readthedocs.io).

## Preparation

#### Requirements

- docker
- docker-compose

##### 1. Install Docker and Docker Compose (with `sudo`).

```
apt install docker.io docker-compose
```

> | :information_source: **Info** |
> | ----------------------------- |
>
> In some cases, the default repositories might be quite outdated.
> In these cases, please consider [the official guides](https://docs.docker.com/engine/install/#server), which will help you with adding the correct PPAs (own sources of the developer/s).

##### 2. Start the docker engine with `service`.

```
service docker start
```

##### 3. Create a user group called _docker_.

```
sudo groupadd docker
```

> | :warning: **Warning** |
> | --------------------- |
>
> **Please be aware of the possible security issues when running Docker as `root`**:
> If you do not want to use it exclusively yourself and locally on your own computer, please consider [Running the Docker daemon as a non-root user](https://docs.docker.com/engine/security/rootless/).

##### 4. Add your user to the `docker` group (might already be done automatically).

```
sudo usermod -aG docker $USER
```

##### 5. Re-login (or restart) to activate the changes to the user group.

## Usage

NEST Desktop and NEST Simulator are built in different images.
Multiple docker containers can be used with `docker` command in different terminals.
You can also change the flag `-d` (instead of `-i`) in `docker` to detach the container.

A better approach to manage multiple containers is `docker-compose`.

#### Use docker

##### 1. Pull docker images for NEST Simulator and NEST Desktop.

```
docker pull nestsim/nest:3.0
docker pull nestdesktop/app:3.0
```

##### 2. Run docker container of NEST Simulator

```
docker run --rm -it -p 5000:5000 nestsim/nest:3.0
```

##### 3. Run docker container of NEST Desktop

```
docker run --rm -it -p 8000:8000 nestdesktop/app:3.0
```

#### Alternative: Use Docker Compose

The Docker Compose is a tool for multi-container Docker applications.
It needs a YAML file to configure services (NEST Desktop and NEST Simulator).

Go to the folder where `docker-compose.yml` is located and then start services.

```
docker-compose up --build
```

Hint: Use `--detach` when it should run in the background, and no logs will be displayed and followed.

For more information, read the [official documentation](https://docs.docker.com/compose/reference/).

##### Further methods

Start a single service.

```
docker-compose start nest-simulator
```

Stop services (but still up).

```
docker-compose stop
```

Restart services.

```
docker-compose restart
```

Shut down services.

```
docker-compose down
```

Pull new container and then create the services.

```
docker-compose pull
docker-compose down
docker-compose up --detach
```
