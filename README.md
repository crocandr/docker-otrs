# OTRS in Docker

## Build OTRS

```
docker build -t croc/otrs otrs
```

## Preconfig

Edit the `docker-compose.yml` file and modify the basic database connection settings.
Example:
```
     - MYSQL_ROOT_PASSWORD=SuperSecret
     - MYSQL_DATABASE=otrs
     - MYSQL_USER=otrs
     - MYSQL_PASSWORD=otrs
```

## Run

```
docker-compose up -d
```

The MySQL containers start about 2-5 mins at the first time. Don't worry about error messages at this time in the OTRS container.
Wait 2-3 minutes and continue with install procedure after the first start.

## Install

You have to setup the database after the first start.

  1. open your http://<docker host ip>/otrs/installer.pl (example: http://192.168.56.101/otrs/installer.pl )
  2. choose MySQL and "use existing database" options and fill the MySQL connection parameters that you use in the `docker-compose.yml` file (example: database - otrs, user - otrs, password - otrs, host - db)
  3. click on next and wait some minutes while the install is running
  4. after the installation finished, click next
  5. check the next form and fill the values with (almost) valid values and click on the next button
  5. set the mail parameters or skip this step and click on the next button
  6. the OTRS install procedure generates a random password for the `root@localhost` admin user. Remember this password. You can log in with this as an admin.
  7. use the normal login URL (http://<docker host ip>/otrs/index.pl) to use OTRS

## Usage

Open the http://<docker host ip>/otrs/index.pl (example: http://192.168.56.101/otrs/index.pl) in your browser and log in.

Default admin login is: `root@localhost` and the password is `root`, but you will get a generated password for this user after the installation procedure. This generated password is more secure than default :)

## Admin tasks

### Check OTRS Daemon

Sometimes the web UI says "The OTRS daemon not running" or something similar problem. You can check the daemon status with this command:
```
docker-compose exec otrs su - otrs -c "/opt/otrs/bin/otrs.Daemon.pl status"
```

## More information

for devs:

  - https://www.howtoforge.com/tutorial/how-to-install-otrs-on-centos-7/
  - https://www.vultr.com/docs/how-to-install-and-configure-otrs-on-ubuntu-16-04

