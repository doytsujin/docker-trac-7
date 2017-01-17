This is a recipe for creating a trac environment for Docker

## Installing

### Clone from GitHub

Clone the project and go into the main folder.

```bash
git clone git@github.com:pyaster/docker-trac.git
```

### Setup trac configuration

Change files in *etc* for adapting to your preferences. 

### Add users

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

### Build and Start

Building and starting trac container for 1st time is performed by:

```bash
./quick-start.sh 
```

## Some Helpers

There are some hepler scripts in the distrubution.

You already know how to create Docker image and run trac container for 1st time
```bash
./quick-start.sh 
```

To *Pause* the trac container
```bash
./pause.sh 
```

To *Resume* the paused trac container
```bash
./resume.sh
```

To *Backup* trac important files
```bash
./backup.sh
```
This script pause the container for a little bit, copy the files in a safe fashion and resume the service ASAP.

And finally just for *testing purproses* the script
```bash
./mrproper.sh
```
DELETE all IMAGES and CONTAINERS and build a clean image

Use as your OWN RISK.

## Manual command line tips

For Building manually the trac image

```bash
docker build -t mytrac .
```
