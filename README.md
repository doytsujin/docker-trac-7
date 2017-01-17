This is a recipe for creating a trac environment for Docker

## Installing

1. Clone the project and go into the main folder.

```bash
htpasswd etc/trac/htpasswd mary
```

2. Setup trac configuration changing files in *etc* 

3. Add users

By default htpasswd file is populated with a admin/admin user.

To change admin password and add new users type:

```bash
htpasswd etc/trac/htpasswd admin
htpasswd etc/trac/htpasswd peter
htpasswd etc/trac/htpasswd mary
```

You may need the apache2-utils package

In a apt based environment (debian, ubuntu, ...) you can install it by:

```bash
apt-get install apache2-utils
```

4. Build and start trac container for 1st time

```bash
./quick-start.sh 
```

## Some Helpers

Create Docker image and run trac container for 1st time
```bash
./quick-start.sh 
```

Pause the trac container
```bash
./pause.sh 
```

Resume the paused trac container
```bash
./resume.sh
```

Backup trac important files
```bash
./backup.sh
```
This script pause the container for a little bit, copy the files in a safe fashion and resume the service ASAP.


Just for testing purproses the script
```bash
./mrproper.sh
```
DELETE all IMAGES and CONTAINERS and build a clean image

Use as your OWN RISK.


## Manual command line tips

Build manually

```bash
docker build -t mytrac .
```
