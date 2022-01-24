# NEST Desktop Docker

Docker container for NEST Desktop and its backends, e.g. NEST Simulator.

For more information, please see the [User Documentation Page of NEST Desktop](https://nest-desktop.readthedocs.io)
as well as the [User Documentation Page of NEST Simulator](https://nest-simulator.readthedocs.io).

## Preparation

#### Requirements

- docker-compose

##### 1. Install Docker and Docker Compose (with `sudo`).

```
apt install docker.io docker-compose
```

##### 2. Start docker engine with service.

```
service docker start
```

##### 3. Create the `docker` group.

```
sudo groupadd docker
```

##### 4. Add your user to the `docker` group.

```
sudo usermod -aG docker $USER
```

## Usage

NEST Desktop and NEST Simulator are built in different images.
Multiple containers can be managed with `docker-compose`.

#### Use Docker Compose

The Docker Compose is a tool for multi-container Docker applications.
It needs a YAML file to configure services (NEST Desktop and NEST Simulator).

Start services with a configuration file in the same directory (By default: `docker-compose.yml`).

```
docker-compose up --build
```

Hint: Use `--detach` when it should run in the background, and no logs will be displayed and followed.

For more information, read the [official documentation](https://docs.docker.com/compose/reference/).

##### Further methods of `docker-compose`

Start services with custom configuration file.

```
docker-compose -f docker-compose-insite.yml up --build
```

Start a single service, e.g. `nest-simulator`.

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
