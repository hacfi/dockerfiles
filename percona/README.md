# Dockerfile for Percona Server 5.6

MySQL credentials are `root` for both username and password.

```
git clone git@github.com:hacfi/dockerfiles.git
cd percona
docker build -t percona .
docker run -d --name db percona
```

Use the `--link db:db` when launching a new container to connect it to the running Percona container. It’s accessible inside the new container via the `db` hostname.