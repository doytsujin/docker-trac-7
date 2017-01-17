## Intro

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
