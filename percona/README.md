# Dockerfile for Percona Server 5.6

MySQL password for `root` has to be set via the env variable MYSQL_ROOT_PASSWORD.

```
git clone git@github.com:hacfi/dockerfiles.git
cd percona
docker build -t percona .
docker run -d -p 3306:3306 --name db -e MYSQL_ROOT_PASSWORD=root percona
```

Use the `--link db:db` when launching a new container to connect it to the running Percona container. It’s accessible inside the new container via the `db` hostname.