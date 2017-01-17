This is a recipe for creaing a trac environment for Docker

## Installing

Clone the project and go into the project.

```bash
docker build -t mytrac .
```

For running a container instance mapping the container port 80 to the external host:80

```bash
docker run -i -p 80:80 -t mytrac
```

## Testing and making a clean build

Just for testing purproses the script
```bash
./mrproper.sh
```
DELETE all IMAGES and CONTAINERS and build a clean image

Use as your OWN RISK.

## Users

Users are added now by modifing the etc/trac/htpasswd file before creating the image. In next versions I'll set another more friendly way.

To perform this type in a console:

```bash
htpasswd -c etc/trac/htpasswd admin
htpasswd etc/trac/htpasswd peter
htpasswd etc/trac/htpasswd mary
```

You may need the apache2-utils package

In a apt based environment (debian, ubuntu, ...) you can install it by:

```bash
apt-get install apache2-utils
```

